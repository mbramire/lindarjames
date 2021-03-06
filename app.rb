require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'pony'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/ddl3r9urh0p0sb')

enable :sessions
set :session_secret, '@*#&28282bkjbkja;'

require_relative 'config/initializers/pony'
require_relative 'config/initializers/carrierwave'
require_relative 'uploaders/image_uploader'
require_relative 'uploaders/document_uploader'
require_relative 'models/models'
require_relative 'helpers/helpers'
require_relative 'routes/routes'

