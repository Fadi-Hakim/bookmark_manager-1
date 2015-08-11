class Tag
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  validates_length_of :name, min: 1

  has n, :links, through: Resource
end