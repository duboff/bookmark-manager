get '/sessions/new' do
  # if session[:user_id]
  #   flash[:notice] = "You seem to be logged in already"
  #   redirect to('/')
  # else
  erb :"sessions/new"
  # end
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password are incorrect"]
    erb :"sessions/new"
  end
end

delete '/sessions' do
  session[:user_id] = nil
  flash[:notice] = 'Good bye!'
  redirect to('/')
end
