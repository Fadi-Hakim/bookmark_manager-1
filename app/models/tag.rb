class Tag
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  validates_presence_of :name

  has n, :links, through: Resource
end