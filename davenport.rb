require 'rubygems'
require 'sinatra/base'
require 'couchrest'
require 'extlib'
require 'stringex'

require 'lib' / 'helpers'
require 'lib' / 'extlib'

Dir['models/*'].each{|m| require m}

class Davenport < Sinatra::Default
  disable :run
  enable :static, :session, :methodoverride, :reload
  set :app_file, __FILE__
  set :views, Proc.new { File.join(root, "views","posts") }
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
    p e.to_s
    p e.backtrace.join('\n')
    'Application error'
  end
  
  get '/' do
    @posts = Post.by_date(:descending => true, :limit => 5)
    haml :index
  end
  
   get '/:year/:month/:day/:slug' do |year,month,day,slug|
    @post = Post.by_archive(:key => [year.to_i,month.to_i,day.to_i,slug]).first
    @title = @post.title
    haml :show
  end
  
  get '/:year(/:month(/:day))' do |year, month, day|
    @group_level = params.values.compact.size - 2
    key = [year.to_i]
    key << month.to_i unless month.nil?
    key << day.to_i unless day.nil?
    puts key.inspect
    @posts = Post.by_archive(:group_level => @group_level, :startkey => key)
    redirect request.referrer if @posts.nil?
    if @posts.size == 1
      redirect url(:post, *@posts.first.path)
    end
    @date = Date.parse("#{month || 1}/#{day || 1}/#{year}")
    haml :archive
  end
  
  get '/tag/:name' do |name|
    @posts = Post.by_tag(:key => name)
    @title = "Posts tagged with #{name}"
    haml :index
  end
  
  get '/category/:name' do |name|
    @posts = Post.by_category(:key => name)
    @title = "Posts in #{name}"
    haml :index
  end
end