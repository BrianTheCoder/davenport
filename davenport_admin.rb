require 'rubygems'
require 'sinatra/base'
# require 'couchrest'
require 'extlib'
require 'stringex'

require 'lib' / 'helpers'

# Dir['models/*'].each{|m| require m}

class DavenportAdmin < Sinatra::Default
  disable :run
  enable :static, :session, :methodoverride, :reload
  set :app_file, __FILE__
  set :views, Proc.new { File.join(root, "views","admin") }
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
    haml :index
  end
  
  post '/' do
    @post = Post.new(params[:post])
    if @post.save
      redirect "/"
    else
      haml :new
    end
  end
  
  put '/:id' do |id|
    @post = Post.get(id)
    if @post.update_attributes(params[:post])
      redirect "/"
    else
      haml :edit
    end
  end
  
  get '/new' do
    @post = Post.new
    haml :new
  end
  
  get '/edit/:id' do |id|
    @post = Post.get(id)
    haml :edit
  end
  
  get '/settings' do
    haml :settings
  end
  
  delete '/:id' do |id|
    @post = Post.get(id)
    @post.destroy
    redirect '/'
  end

end