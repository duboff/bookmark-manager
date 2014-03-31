get '/' do
  @links = Link.all
  @tags = Tag.all
  erb :index
end
