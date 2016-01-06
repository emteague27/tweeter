require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models.rb"

set :database, "sqlite3:tweeterdb.sqlite3"

enable :sessions

get '/' do 
	erb :'sign-in', :layout => false
end

get '/home' do
	@user = current_user
	@posts = Post.all.reverse
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
	@user = current_user
	erb :'edit-account'
end

get '/delete' do
	erb :'delete-account'
end

get '/logout' do
	session.clear
	redirect '/'
end

post '/sign-in' do
	@user = User.where(username: params[:username]).last
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You have signed in"
		redirect '/home'
	else
		# flash[:notice] = "\"I thawt I taw a puddy tat!\" Sylvester says your username or password is incorrect."
		redirect '/error'
	end
end

post '/sign-up' do
	@user = User.create(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], email: params[:email], birthdate: params[:birthdate])
	session[:user_id] = @user.id
	redirect '/home'
end

post '/edit_account' do
	@user = current_user
	@user.update(fname: params[:fname], lname: params[:lname], username: params[:username], password: params[:password], email: params[:email], birthdate: params[:birthdate])
	redirect '/account'
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

post '/twit' do
	@posts = Post.new(title: params[:title], body: params[:text], user_id: current_user.id)
	@posts.save
	redirect '/home'
end

post '/delete' do
	@user = current_user
	@user.delete
	session.clear
	redirect '/'
end

get '/error' do
	erb :'error'
end
