Merb.logger.info("Loaded PRODUCTION Environment...")
Merb::Config.use { |c|
  c[:environment]         = 'production'
  c[:exception_details] = false
  c[:reload_classes] = false
  c[:log_level] = :error
  c[:log_file]  = Merb.root / "log" / "production.log"
  c[:use_mutex]           = false
  c[:session_store]       = 'cookie'
  c[:session_id_key]      = '_brianthecoder_session_id'
  c[:session_secret_key]  = '2552f3961c6599740f76825eb11d6bfb70c4b7c5'
}