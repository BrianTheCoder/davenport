require 'dm-sweatshop'

tags = 15.of{ /\w+/.gen.downcase }
categories = 5.of{ /\w+/.gen.downcase }

Post.fixture {{
  :title => /[:sentence:]/.gen,
  :body => 3.of{ /[:paragraph:]/.gen }.join('\n'),
  :tags => (1..4).of{ tags.pick},
  :category => categories.pick,
  :published_at => (4.days.ago..Time.now).pick
}}