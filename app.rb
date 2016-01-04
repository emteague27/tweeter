require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"

set :database, "sqlite3:tweeterdb.sqlite3"
