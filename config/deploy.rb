set :application, 'davenport'
set :user,        'app'
set :domain,      '72.14.182.34'
set :deploy_to,   "/data/#{application}"
set :repository,  "git@github.com:dkubb/#{application}.git "

namespace :vlad do
  ##
  # Thin app server

  set :thin_address,     '127.0.0.1'
  set :thin_command,     'thin'
  set(:thin_conf)        { "#{shared_path}/thin_cluster.conf" }
  set :thin_environment, 'production'
  set :thin_group,       nil
  set :thin_log_file,    nil
  set :thin_pid_file,    nil
  set :thin_port,        nil
  set :thin_socket,      '/tmp/thin.sock'
  set :thin_prefix,      nil
  set :thin_servers,     4
  set :thin_user,        nil
end
