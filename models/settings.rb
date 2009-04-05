class Settings < CouchRest::ExtendedDocument   
  include CouchRest::Validation
  include Extlib::Hook

  use_database CouchRest.database!('davenport')
  
  property :title
  property :taglines
  property :markup_engine
  
end