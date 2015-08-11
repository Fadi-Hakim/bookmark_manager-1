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
    tags = (params["tags"]).split

    link = Link.new(title: title, url: url)

    tags.each do |name|
      tag = Tag.create(name: name)
      link.tags << tag
    end

    if link.save
      redirect to('/links')
    end
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    @requested_tag = params[:name]
    @links_by_tag = []
    tags = Tag.all(name: @requested_tag)
    tags.each do |tag|
      tag.links.each do |link|
        @links_by_tag << link
      end
    end

    erb :'links/index'
  end
end