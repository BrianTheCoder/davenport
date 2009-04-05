set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage'
 
# before "deploy:setup", "db:password"
 
# namespace :deploy do
#   desc "Default deploy - updated to run migrations"
#   task :default do
#     set :migrate_target, :latest
#     update_code
#     migrate
#     symlink
#     restart
#   end
#   desc "Run this after every successful deployment"
#   task :after_default do
#     cleanup
#   end
# end
#  
# namespace :db do
#   desc "Create database password in shared path"
#   task :password do
#     set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
#     run "mkdir -p #{shared_path}/config"
#     put db_password, "#{shared_path}/config/dbpassword"
#   end
# end

# after "deploy:symlink" do
#   run "ln -s #{shared_path}/database.yml #{current_path}/config/database.yml"
# end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  task :migrate do
  end
end