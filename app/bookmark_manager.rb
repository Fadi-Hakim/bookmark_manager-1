require_relative 'data_mapper_setup.rb'
require 'sinatra/base'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    "Hello"  
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    tags = (params[:tags]).split
    link = Link.new(title: params[:title], url: params[:url])
    create_link_tags(link, tags)

    if link.save
      redirect to('/links')
    end
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    @requested_tag = params[:name]
    tags = Tag.all(name: @requested_tag)

    @links_by_tag = get_links_by_tag(tags)

    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end

  def create_link_tags link, tags
    tags.each do |name|
      tag = Tag.create(name: name)
      link.tags << tag
    end
  end

  def get_links_by_tag(tags)
    @result = []

    tags.each do |tag|
      tag.links.each do |link|
        @result << link
      end
    end
    @result
  end

  helpers do
    def current_user
      User.get(session[:user_id])
    end
  end
end