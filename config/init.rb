# Go to http://wiki.merbivore.com/pages/init-rb
use_test :rspec
use_template_engine :haml

# Merb::Plugins.config[:haml] = {
#   :attr_wrapper => '"',
#   :escape_html  => true,
# }

Merb::BootLoader.after_app_loads do
  require Merb.root / 'lib' / 'sass-script-functions'
end

TAGLINES = ["Get ready to have your mind blown","You can't handle the awesome"]


require 'lib/extlib'
require 'config/dependencies.rb'

#ps aux | grep merb | awk '{print $2}' | xargs kill -9