require 'sass/plugin'

module Sass::Script::Functions

  # transparently append a random query string to all url() declarations
  def url(path)
    path = path.to_s

    # figure out the absolute path
    path = if path =~ %r{\A(?:https?://|/)}
      path
    else
      "#{Merb::Config[:path_prefix] || ''}/images/" + path
    end

    # append a random number on the query string
    random_query_string = Time.now.strftime("%m%d%H%M%S#{rand(99)}")
    path += path.include?('?') ? "&#{random_query_string}" : "?#{random_query_string}"

    Sass::Script::String.new("url(\"#{path}\")")
  end
end
