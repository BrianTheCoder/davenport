# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.0.7"
dm_gems_version   = "0.9.8"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
dependency "merb-assets", merb_gems_version
dependency "merb-cache", merb_gems_version
dependency "merb-haml", merb_gems_version
dependency "merb-helpers", merb_gems_version
dependency "merb-slices", merb_gems_version
dependency "merb-auth-core", merb_gems_version
dependency "merb-auth-more", merb_gems_version
dependency "merb-exceptions", merb_gems_version
dependency "merb_datamapper", merb_gems_version

dependency "dm-core", dm_gems_version
dependency "dm-timestamps", dm_gems_version
dependency "dm-validations", dm_gems_version
# dependency "dm-couchdb-adapter", dm_gems_version

dependency "chriseppstein-compass", "0.3.4", :require_as => "compass"     # sudo gem install chriseppstein-compass --source http://gems.github.com
dependency "haml",                  "2.1.0"                               # From: http://github.com/nex3/haml/
dependency "ParseTree",             "3.0.2", :require_as => "parse_tree"
dependency "ruby2ruby",             "1.2.1"
dependency "rack-cache",            "0.2.0", :require_as => "rack/cache"
dependency "system_timer",          "1.0"
