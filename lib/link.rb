class Link

  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :url, String
  property :description, Text
  property :creator, Object


  has n, :tags, :through => Resource
  has n, :users, :through => Resource

  validates_presence_of :title
  validates_presence_of :url
end
