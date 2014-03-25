require 'bcrypt'

class User

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email, String

  property :password_digest, Text

  def password=(password)
    self.password_digest = Password.create(password)
  end



  # has n, :tags, :through => Resource

end
