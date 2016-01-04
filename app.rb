require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models.rb"

set :database, "sqlite3:tweeterdb.sqlite3"
