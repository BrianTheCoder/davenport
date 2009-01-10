class Posts < Application
  def index
    @posts = Post.by_date(:group => true, :descending => true)
    display @posts
  end
  
  def show(year, month, day, slug)
    puts [year,month,day,slug].inspect
    @post = Post.archive(:group => true, :key => [year,month,day,slug]).first
    @title = @post.title
    display @post
  end
  
  def archive(year,month = nil,day = nil)
    @posts = Post.all(:order => [:created_at.desc])
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