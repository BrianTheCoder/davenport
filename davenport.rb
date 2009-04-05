require 'rubygems'
require 'sinatra/base'
# require 'couchrest'
require 'extlib'
require 'stringex'

require 'lib' / 'helpers'

# Dir['models/*'].each{|m| require m}

class Davenport < Sinatra::Default
  disable :run
  enable :static, :session, :methodoverride, :reload
  set :app_file, __FILE__
  # set :env, :production
  
  before do
    new_params = {}
    params.each_pair do |full_key, value|
      this_param = new_params
      split_keys = full_key.split(/\]\[|\]|\[/)
      split_keys.each_index do |index|
        break if split_keys.length == index + 1
        this_param[split_keys[index]] ||= {}
        this_param = this_param[split_keys[index]]
     end
     this_param[split_keys.last] = value
    end
    request.params.replace new_params
  end
  
  error do
    e = request.env['sinatra.error']
    puts e.to_s
    puts e.backtrace.join('\n')
    'Application error'
  end
  
  get '/' do
    @posts = Post.by_date(:descending => true)
    haml :"posts/index"
  end
  
   get '/:year/:month/:day/:slug' do |year,month,day,slug|
    @post = Post.archive(:group => true, :key => [year.to_i,month.to_i,day.to_i,slug]).first
    @title = @post.title
    haml :"posts/show"
  end
  
  get '/:year(/:month(/:day))' do |year, month, day|
    @group_level = params.values.compact.size - 2
    key = [year.to_i]
    key << month.to_i unless month.nil?
    key << day.to_i unless day.nil?
    puts key.inspect
    @posts = Post.archive(:group_level => @group_level, :startkey => key)
    redirect request.referrer if @posts.nil?
    if @posts.size == 1
      redirect url(:post, *@posts.first.path)
    end
    @date = Date.parse("#{month || 1}/#{day || 1}/#{year}")
    haml :"posts/archive"
  end
  
  get '/tag/:name' do |name|
    @posts = Post.by_tag(:group => true, :key => name)
    @title = "Posts tagged with #{name}"
    haml :"posts/index"
  end
  
  get '/category/:name' do |name|
    @posts = Post.by_category(:group => true, :key => name)
    @title = "Posts in #{name}"
    haml :"posts/index"
  end

end