require 'bcrypt'

class User

  attr_reader :password
  attr_accessor :password_confirmation

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"

  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"
  validates_uniqueness_of :email

end
