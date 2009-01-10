class Posts < Application
  def index
    @posts = Post.by_date(:descending => true)
    display @posts
  end
  
  def show(year, month, day, slug)
    puts [year,month,day,slug].inspect
    @post = Post.archive(:group => true, :key => [year.to_i,month.to_i,day.to_i,slug]).first
    @title = @post.title
    display @post
  end
  
  def archive(year, month, day)
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
    render
  end
  
  def tag(name)
    @posts = Post.by_tag(:group => true, :key => name)
    @title = "Posts tagged with #{name}"
    display @posts, :template => "posts/index"
  end
  
  def category(name)
    @posts = Post.by_category(:group => true, :key => name)
    @title = "Posts in #{name}"
    display @posts, :template => "posts/index"
  end
end