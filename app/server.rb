require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'a very long and random'

get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params[:url]
  title = params[:title]
  tags = params[:tags].split(' ').map do |tag|
    Tag.first_or_create(:text => tag)
  end
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

get '/tags/:text' do
  tag = Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :index
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.create(:email => params[:email],
                     :password => params[:password])
  session[:user_id] = user.id
  redirect to('/')
end

def add_link(url, title, tags = [])
  within('#new-link') do
    fill_in 'url', :with => url
    fill_in 'title', :with => title
    fill_in 'tags', :with => tags.join(' ')
    click_button 'Add link'
  end
end
