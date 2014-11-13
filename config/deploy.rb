# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'junco'
set :repo_url, "git@github.com:UVM-BIRD/#{fetch :application}.git"
set :deploy_to, "/home/rails/#{fetch :application}"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :branch, :master

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

# tomcat settings


# useful for debugging!
namespace :env do
  task :echo do
    run 'echo printing out cap info on remote server'
    run 'printenv'
  end
end

namespace :deploy do
  desc 'Build WAR'
  task :build_war do
    on roles(:app) do
      within release_path do
        with rails_env: :production do
          execute :bundle, :exec, :warble
        end
      end
    end
  end

  desc 'Deploy WAR'
  task :deploy_war do
    on roles(:app) do
      within release_path do
        with rails_env: :production do
          execute :cp, "#{fetch :application}.war", '/usr/share/tomcat6/webapps/'
        end
      end
    end
  end

  desc 'Seed the database'
  task :db_seed do
    on roles(:app) do
      within release_path do
        with rails_env: :production do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :updated, :db_seed
  after :updated, :build_war
  after :build_war, :deploy_war

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
