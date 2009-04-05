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

# use PathPrefix Middleware if :path_prefix is set in Merb::Config
if prefix = ::Merb::Config[:path_prefix]
  use Merb::Rack::PathPrefix, prefix
end

# comment this out if you are running merb behind a load balancer
# that serves static files
use Merb::Rack::Static, Merb.dir_for(:public)

run Merb::Rack::Application.new