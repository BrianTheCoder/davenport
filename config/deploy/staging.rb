# For migrations
set :rails_env, 'staging'
 
# Who are we?
set :application, 'davenport'
set :repository, "git@github.com:BrianTheCoder/#{application}.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "master"
 
default_run_options[:pty] = true
set :use_sudo, true

# Where to deploy to?
set :domain, "67.23.1.101"
role :web, "#{domain}"
role :app, "#{domain}"
role :db, "#{domain}", :primary => true
 
# Deploy details
set :user, "app"
set :deploy_to, "/data/#{application}"
 
# We need to know how to use mongrel
# set :mongrel_rails, '/usr/local/bin/mongrel_rails'
# set :mongrel_cluster_config, "#{deploy_to}/#{current_dir}/config/mongrel_cluster_staging.yml"
