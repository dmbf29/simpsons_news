require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "faker"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative "config/application"

after do
  ActiveRecord::Base.clear_active_connections!
end

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'

get '/' do
  @posts = Post.by_most_popular
  @post  = Post.new
  @users = User.all
  @quote = Faker::TvShows::Simpsons.quote

  erb :posts # Do not remove this line
end

# Post creation
post '/posts' do
  @post         = Post.new
  @post.name    = params[:name]
  @post.url     = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  @post.user_id = params[:user_id]
  @post.save

  if @post.save
    redirect to('/')
  else
    erb :new_post
  end
end

# Post upvote
put '/posts/:id/upvote' do
  post = Post.find(params[:id])
  puts
  p post
  puts
  post.votes += 1
  post.save

  redirect to('/')
end
