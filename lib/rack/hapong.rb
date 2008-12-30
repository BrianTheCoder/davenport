module Rack
  class HAPong
    REQUEST_METHOD = 'REQUEST_METHOD'.freeze
    REQUEST_URI    = 'REQUEST_URI'.freeze
    OPTIONS        = 'OPTIONS'.freeze
    ROOT           = '/'.freeze

    if Merb.environment == 'development'
      HEADERS = { 'Allow' => 'GET,OPTIONS', 'Content-Type' => 'text/plain', 'Content-Length' => '6' }.freeze
      STATUS  = 200
      BODY    = [ "PONG!\n" ].freeze
    else
      HEADERS = { 'Allow' => 'GET,OPTIONS' }.freeze
      STATUS  = 204
      BODY    = [].freeze
    end

    RESPONSE = [ STATUS, HEADERS, BODY ].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      if env[REQUEST_METHOD] == OPTIONS && env[REQUEST_URI] == ROOT
        RESPONSE
      else
        @app.call(env)
      end
    end
  end
end
