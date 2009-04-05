require 'lib/rack/hapong'
require 'rack/cache'
require 'merb-core'

# Test response when in development mode
# if Merb.environment == 'development'
#  use Rack::Lint
# end

# handle OPTIONS / requests without invoking any handlers
use Rack::HAPong

# use HTTP caching
use Rack::Cache do
  import 'rack/cache/config/default'
  import 'rack/cache/config/no-cache'
  import 'rack/cache/config/busters'

  # log cache hit/miss/pass when in development mode
  # set :verbose, Merb.environment == 'development'

  # override the default behavior to not cache when a cookie header is sent
  on :receive do
    pass! unless request.method? 'GET', 'HEAD'
    pass! if request.header? 'Authorization', 'Expect'
    lookup!
  end
end

# Compress output when in development mode
#if Merb.environment == 'development'
#  use Rack::Deflater
#end
# 

require 'rack/auth/abstract/handler'
require 'rack/auth/abstract/request'

module Rack
  module Auth
    class Admin < AbstractHandler
      def call(env)
        if env['PATH_INFO'].match(/\/admin/)
          auth = Basic::Request.new(env)
          return unauthorized unless auth.provided?
          return bad_request unless auth.basic?
          if valid?(auth)
            env['REMOTE_USER'] = auth.username
            return @app.call(env)
          end
          unauthorized
        else
          @app.call(env)
        end
      end

      private
      
      def challenge
        'Basic realm="%s"' % realm
      end
      
      
      def valid?(auth)
        @authenticator.call(*auth.credentials)
      end

      class Request < Auth::AbstractRequest
        def basic?
          :basic == scheme
        end

        def credentials
          @credentials ||= params.unpack("m*").first.split(/:/, 2)
        end

        def username
          credentials.first
        end
      end

    end
  end
end

use Rack::Auth::Admin do |username, password|
  'bugaboo' == password
end

# comment this out if you are running merb behind a load balancer
# that serves static files
Merb::Config.setup(:merb_root => ".", :environment => ENV['RACK_ENV'])
Merb.environment = Merb::Config[:environment]
Merb.root = Merb::Config[:merb_root]
Merb::BootLoader.run
 
use Merb::Rack::Static, Merb.dir_for(:public)
run Merb::Rack::Application.new