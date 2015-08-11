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
    tags = Tag.all(name: @requested_tag)

    @links_by_tag = get_links_by_tag(tags)

    erb :'links/index'
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
end