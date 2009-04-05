class Post < CouchRest::ExtendedDocument   
  include CouchRest::Validation
  include Extlib::Hook
 
  use_database CouchRest.database!('davenport')
  
  property :published_at
  property :title
  property :body
  property :tags
  property :category
  property :slug, :read_only => true
  
  timestamps!
  
  def path
    published_at.strftime('%Y/%m/%d').split('/') + [slug]
  end

  view(:by_date){{
    :map => "function(doc){ 
      if(doc.couchdb_type == '#{self}'){
        emit(Date.parse(doc.published_at), doc)
      }
    }"
  }}
  
  view(:tag_count){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
        for(var tag in doc.tags){
          emit(doc.tags[tag], 1);
        }
      }
    }",
    :reduce => "function(keys,values,combine){
      return sum(values);
    }"
  }}
  
  view(:category_count){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
          emit(doc.category, 1);
      }
    }",
    :reduce => "function(keys,values,combine){
      return sum(values);
    }"
  }}
  
  view(:by_tag){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
        for(var tag in doc.tags){
          emit(doc.tags[tag], doc);
        }
      }
    }"
  }}
  
  view(:by_category){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
          emit(doc.category, doc);
      }
    }"
  }}
  
  view(:archive_count){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
        var date = new Date(Date.parse(doc.published_at))
        emit([date.getFullYear(),(date.getMonth()+1)], 1)
      }
    }",
    :reduce => "function(keys,values,combine){
      return sum(values);
    }"
  }}
  
  view(:archive){{
    :map => "function(doc){
      if(doc.couchdb_type == '#{self}'){
        var date = new Date(Date.parse(doc.published_at))
        emit([date.getFullYear(), (date.getMonth()+1), date.getDate(), doc.slug],doc)
      }
    }"
  }}
  
  before :save do
    self['slug'] = title.to_url
    self['tags'] = tags.split(',').map{|t| t.strip} if tags.is_a? String
  end
end
