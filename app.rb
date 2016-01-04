require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models.rb"

set :database, "sqlite3:tweeterdb.sqlite3"

get '/' do 
	erb :'sign-in'
end

get '/home' do
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

end