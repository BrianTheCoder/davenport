class Admin < Application
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
  
  def index
    @posts = Post.by_date(:descending => true)
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
end