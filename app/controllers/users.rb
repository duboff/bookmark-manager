get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.create(:email => params[:email],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
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
    user.password_token_timestamp = Time.now
    user.save
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
