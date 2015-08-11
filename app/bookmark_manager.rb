require_relative 'data_mapper_setup.rb'
require 'sinatra/base'


class BookmarkManager < Sinatra::Base

  get '/' do
    "Hello"  
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/link/create' do
    url = params["url"]
    title = params["title"]

    link = Link.new(title: title, url: url)

    if link.save
      redirect to('/links')
    end
  end
end