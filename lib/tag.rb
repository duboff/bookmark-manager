class Tag

  include DataMapper::Resource

  property :id, Serial
  property :text, String
  property :user_id, String

  has n, :links, :through => Resource
  has n, :users, :through => Resource


end
