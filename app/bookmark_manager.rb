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

  post '/links' do
    url = params["url"]
    title = params["title"]
    tag = params["tag"]

    link = Link.new(title: title, url: url)
    tag = Tag.create(name: params["tag"])

    link.tags << tag

    if link.save
      redirect to('/links')
    end
  end

  get '/links/new' do
    erb :'links/new'
  end
end