require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'
require 'sinatra/partial'
require 'mandrill'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'helpers/sendemail'
require_relative 'helpers/timestamp'
require_relative 'data_mapper_setup'




require_relative 'controllers/application'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/users'
require_relative 'controllers/sessions'

enable :sessions
set :session_secret, 'a very long and random'
set :partial_template_engine, :erb

use Rack::Flash
