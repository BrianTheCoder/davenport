class Admin < Application
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect url(:admin)
    else
      render :new
    end
  end
  
  def update(id)
    @post = Post.get(id)
    if @post.update_attributes(params[:post])
      redirect url(:admin_posts)
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
  
  def edit(id)
    @post = Post.get(id)
    render
  end
  
  def settings
    render
  end
  
  def destroy(id)
    @post = Post.get(id)
    @post.destroy
  end
end