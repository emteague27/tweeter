require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models.rb"

set :database, "sqlite3:tweeterdb.sqlite3"

enable :sessions

get '/' do 
	erb :'sign-in'
end

get '/home' do
	@user = current_user
	erb :home
end

get '/profile/:id' do
	erb :profile
end

get '/account' do
	erb :account
end

get '/new-post' do
	erb :'new-post'
end

get '/following' do
	erb :following
end

get '/edit_account' do
	erb :'edit-account'
end

get '/delete' do
	erb :'delete-account'
end

post '/sign-in' do
	@user = User.where(username: params[:username]).last
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You have signed in"
		redirect '/home'
	else
		flash[:notice] = "I thought I thaw a puddytat"
		redirect '/'
	end
end

post '/sign-up' do
	@user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], email: params[:email], birthdate: params[:birthdate])
	redirect '/home'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end
