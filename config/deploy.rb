# This config is valid only for Capistrano 3.1.
lock '3.2.1'

set :application, 'Handy'
set :deploy_to, '/u/apps/handy'
set :keep_releases, 5

# Git
set :scm, :git
set :repo_url, 'git@github.com:Pitt-CSC/handy.git'
set :branch, 'master'

# Ruby
set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_custom_path, '/opt/rbenv'

# Rails
set :linked_files, %w(config/database.yml config/secrets.yml config/twilio.yml)

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
