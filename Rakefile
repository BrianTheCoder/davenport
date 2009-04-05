desc "Populate the db"
task :populate do
  require 'davenport'
  require 'faker'
  
  @cr = CouchRest.new
  @cr.database('davenport').delete!
  @cr.database!('davenport')
  
  100.times do
    p = Post.new(
      :title => Faker::Lorem.sentence, 
      :body => Faker::Lorem.paragraph, 
      :tags => Faker::Lorem.words,
      :category => Faker::Lorem.words.first,
      :published_at => Time.now - (1000..100000).pick
    )
    puts p.inspect
    p.save
  end
end

