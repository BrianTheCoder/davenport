class Post
  include DataMapper::CouchResource
  
  property :created_at,         DateTime
  property :updated_at,         DateTime
  property :title,              String
  property :body,               Text
  property :tags,               DataMapper::Types::JsonObject, :default => []
  property :category,           String

  view :by_date, { "map" => "function(doc) { emit(doc.created_at, doc) }"}
  
  before :save do
    attribute_set(:tags, tags.split(',').map{|t| t.strip}) if tags.is_a? String
  end
end
