# Go to http://wiki.merbivore.com/pages/init-rb
use_orm :datamapper
use_test :rspec
use_template_engine :haml

# Merb::Plugins.config[:haml] = {
#   :attr_wrapper => '"',
#   :escape_html  => true,
# }

Merb::BootLoader.before_app_loads do
  DataMapper.setup(:default, "couchdb://localhost:5984/brianthecoder")
end
 
Merb::BootLoader.after_app_loads do
  require Merb.root / 'lib' / 'sass-script-functions'
end

TAGLINES = ["Get ready to have your mind blown","You can't handle the awesome"]


require 'lib/extlib'
require 'config/router.rb'
require 'config/dependencies.rb'