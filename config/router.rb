Merb::Router.prepare do
  to(:controller => "admin") do
    match('/admin/posts', :method => :post).to(:action =>'create').name(:posts)
    match('/admin/posts').to(:action =>'index').name(:admin_posts)
    match('/admin/post/new').to(:action =>'new').name(:new_post)
    match('/admin/post/:id', :method => :delete).to(:action =>'destroy').name(:admin_post)
    match('/admin/post/:id', :method => :put).to(:action =>'update').name(:admin_post)
    match('/admin/post/:id').to(:action =>'edit').name(:edit_post)
    match('/admin/settings').to(:action => 'settings').name(:admin_settings)
    # to(:subdomain => "admin") do
    #   match('/posts', :method => :post).to(:action =>'create').name(:posts)
    #   match('/posts').to(:action =>'index').name(:admin)
    #   match('/post/new').to(:action =>'new').name(:new_post)
    #   match('/post/:id', :method => :put).to(:action =>'update').name(:post)
    #   match('/post/:id').to(:action =>'edit').name(:edit_post)
    #   match('/settings').to(:action => 'settings').name(:admin_settings)
    # end
  end
  match('/admin').defer_to do |request, params|
    redirect("/admin/posts")
  end
  to(:controller => "posts") do
    match('/').to(:action =>'index').name(:home)
    match('/tag/:name').to(:action => "tag").name(:tag)
    match('/category/:name').to(:action => "category").name(:category)
    match('/:year(/:month(/:day))(.:format)').to(:action => "archive").name(:archive)
    match('/:year/:month/:day/:slug').to(:action =>'show').name(:post)
  end
end