# TODO: figure out how to avoid the Vlad/DM conflict.  This temporarily
# fixed the problem for now
unless ARGV.any? && %w[ dm: db: ].include?(ARGV[0][0..2])
  Kernel.send(:undef_method, :repository)

  begin
    require 'tempfile'

    gem 'vlad', '1.2.0'
    require 'vlad'

    begin
      Vlad.load :scm => :git, :app => :thin
    rescue
      raise 'Copy example/vlad.rake from thin gem directory to vlad gem directory as lib/vlad/thin.rb'
    end

    # copy the local database.yml.deploy to remote dir
    remote_task :update do
      put("#{current_path}/config/database.yml") { File.read('config/database.deploy.yml') }
    end

    # TODO: figure out how to remove the migrate task Vlad adds
    namespace :migrate do
      desc 'Migrate the database up.'
      remote_task :up, :roles => :app do
        run "cd #{current_release}; #{rake_cmd} dm:db:migrate:up #{migrate_args} MERB_ENV=#{thin_environment}"
      end

      desc 'Migrate the database down.'
      remote_task :down, :roles => :app do
        run "cd #{current_release}; #{rake_cmd} dm:db:migrate:down #{migrate_args} MERB_ENV=#{thin_environment}"
      end
    end

    desc 'Deploy the application'
    task :deploy => %w[ vlad:update vlad:migrate:up vlad:start_app ]
  rescue LoadError
    # do nothing
  end
end
