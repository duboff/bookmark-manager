post '/links' do
  url = params["url"]
  title = params["title"]
  creator = User.first(:id => session[:user_id])
  user_id = creator.id
  tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag, :user_id => user_id)}
  link = Link.create(:url => url,
                     :title => title,
                     :tags => tags,
                     :user_id => user_id,
                     :creator => creator)
  if request.xhr?
    erb :link, :locals => {:link => link}, :layout => false
  else
    redirect to('/')
  end
end

get '/links/new' do
  redirect to('/sessions/new') if session[:user_id] == nil
  erb :"links/new", :layout => !request.xhr?
end

post '/links/favourite' do
  link = Link.first(:id => params[:link_id])
  user = User.first(:id => session[:user_id])
  favs = user.links
  favs << link
  user.update(:links => favs)
  redirect to('/')
end
