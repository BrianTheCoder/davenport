Merb.logger.info("Loaded DEVELOPMENT Environment...")
Merb::Config.use { |c|
  c[:exception_details] = true
  c[:reload_templates] = true
  c[:reload_classes] = true
  c[:reload_time] = 0.5
  c[:ignore_tampered_cookies] = true
  c[:log_auto_flush ] = true
  c[:log_level] = :debug
  c[:log_stream] = STDOUT
  c[:log_file]   = nil
  c[:use_mutex]           = false
  c[:session_store]       = 'cookie'
  c[:session_id_key]      = '_brianthecoder_session_id'
  c[:session_secret_key]  = '2552f3961c6599740f76825eb11d6bfb70c4b7c5'
  c[:compass] = {
    :stylesheets          => 'stylesheets',
    :compiled_stylesheets => 'public/stylesheets/compiled'
  }
}