require 'bcrypt'

class User

  attr_reader :password
  attr_reader :email
  attr_accessor :password_confirmation

  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email, String, :format => :email_address, :unique => true, :message => "This email is already taken"

  property :username, String, :unique => true, :message => "This username is already taken"
  property :password_digest, Text
  property :password_token, Text
  property :password_token_timestamp, Text
  property :description, Text

  has n, :links, :through => Resource
  has n, :tags, :through => Resource

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"
  validates_presence_of :email
  validates_presence_of :password

end
