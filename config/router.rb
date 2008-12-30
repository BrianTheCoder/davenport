Merb::Router.prepare do
  to(:controller => "brianthecoder") do
    match('/admin/posts', :method => :post).to(:action =>'create').name(:posts)
    match('/admin/posts').to(:action =>'admin').name(:admin)
    match('/admin/post/new').to(:action =>'new').name(:new_post)
    match('/admin/post/:id', :method => :put).to(:action =>'update').name(:post)
    match('/admin/post/:id').to(:action =>'edit').name(:edit_post)
    match('/:id').to(:action =>'show').name(:post)
    match('/').to(:action =>'index').name(:home)
  end
end