require 'bcrypt'

class User

  attr_reader :password
  attr_accessor :password_confirmation

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email, String, :unique => true

  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  validates_confirmation_of :password
  validates_uniqueness_of :email



  # has n, :tags, :through => Resource

end
