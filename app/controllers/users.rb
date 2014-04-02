get '/users/new' do
  # if session[:user_id]
  #   flash[:notice] = "You seem to be logged in already"
  #   redirect to('/')
  # else
  @user = User.new
  erb :"users/new"
  # end
end

post '/users' do
  @user = User.create(:email => params[:email],
                      :username => params[:username],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    send_welcome_email(@user.email)
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/users/passwordreset' do
  erb :'users/passwordreset'
end

post '/users/passwordreset' do
  user = User.first(:email => params[:email])
  if user
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now.to_i.to_s
    user.save
    send_recovery_email(user.email, user.password_token)
    redirect to('/users/passwordreset/success')
  else
    redirect to('/users/passwordreset/fail')
  end
end

get '/users/passwordreset/success' do
  erb :'users/passwordreset_success'
end

get '/users/passwordreset/fail' do
  erb :'users/passwordreset_fail'
end

get '/users/passwordreset/:password_token' do
  token = params[:token]
  user = User.first(:password_token => token)
  if too_late?(user.password_token_timestamp)
    erb :'users/reset_password/fail'
  else
    erb :'users/reset_password'
  end
end

post '/users/reset_success' do
  token = params[:token]
  @user = User.first(:password_token => token)
  if @user.email == params[:email]
    @user.update(:password => params[:password], :password_confirmation => params[:password_confirmation], :password_token => nil, :password_token_timestamp => nil)
  else
    flash[:notice] = 'Something went wrong. Please try again.'
  end
  redirect to('/')
end

get '/users/:email' do
  @user = User.first(:email => params[:email])
  @links_created = @user ? Link.all(:creator => @user) : []
  @links_favourited = @user ? @user.links : []
  @tags = @user ? Tag.all(:user_id => @user.id) : []
  erb :user_profile
end
