module Sinatra
  module Helpers
    def link_to(name, url, options = {})
      defaults = {:href => url}
      %Q[<a #{defaults.merge(options).to_html_attributes}>#{name}</a>]
    end

    def css_link(name, options = {})
      name = "/stylesheets/#{name}.css" unless remote_asset?(name)
      defaults = {:href => name, :media => "screen",
        :rel => "stylesheet", :type => "text/css"}
      %Q[<link #{defaults.merge(options).to_html_attributes}/>]
    end

    def js_link(name, options = {})
      name = "/javascripts/#{name}.js" unless remote_asset?(name)
      defaults = {:src => name, :type => "text/javascript"}
      %Q[<script #{defaults.merge(options).to_html_attributes}></script>]
    end
    
    def partial(template, opts = {})
      opts.merge!(:layout => false)
      template = :"partials/#{template}"
      if collection = opts.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << haml(template, opts.merge(
                                    :layout => false, 
                                    :locals => {template.to_sym => member}
                                  )
                       )
        end.join("\n")
      else
        haml(template, opts)
      end
    end
    
    private
    
    def remote_asset?(uri)
      uri =~ %r[^\w+://.+]
    end
  end # Helpers

  helpers Helpers
end # Sinatra