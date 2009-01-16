class Settings
  include DataMapper::CouchResource
  
  property :title,            String, :length => 200
  property :taglines,         DataMapper::Types::JsonObject, :default => ['this is a tagline']
  property :markup_engine,    String, :default => 'none'
  
end