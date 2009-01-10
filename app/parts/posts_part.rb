class PostsPart < Merb::PartController

  def recent_posts(limit = 5)
    @posts = Post.by_date(:group => true, :limit => limit, :descending => true)
    render
  end
  
  def tag_list(limit = 10)
    @tags = Post.tag_count(:group => true).sort_by{|row| row.value}.reverse[0..limit]
    render
  end
  
  def archive_list
    @archive = Post.archive_count(:group => true)
    render
  end

end
