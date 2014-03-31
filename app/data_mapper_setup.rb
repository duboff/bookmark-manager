env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

require './lib/user'
require './lib/link'
require './lib/tag'

DataMapper.finalize

DataMapper.auto_upgrade!
