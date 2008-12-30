class Brianthecoder < Merb::Controller
  def index
    @posts = Post.all(:order => [:created_at.desc])
    render
  end
  
  def show
    @post = Post.get(params[:id])
    render
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect url(:admin)
    else
      render :new
    end
  end
  
  def update
    @post = Post.get(params[:id])
    if @post.update_attributes(params[:post])
      redirect url(:admin)
    else
      render :edit
    end
  end
  
  def admin
    @posts = Post.all(:order => [:created_at.desc])
    render
  end
  
  def new
    @post = Post.new
    render
  end
  
  def edit
    @post = Post.get(params[:id])
    render
  end
  
  def archive
    @posts = Post.all(:order => [:created_at.desc])
    render
  end
end