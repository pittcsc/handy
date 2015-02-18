# This config is valid only for Capistrano 3.2.1.
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
set :rbenv_ruby, '2.2.0'
set :rbenv_custom_path, '/opt/rbenv'

# Configuration
set :linked_files, %w(config/database.yml config/secrets.yml config/twilio.yml)
set :linked_dirs, %w(log)

namespace :deploy do
  after :publishing, :restart

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
    invoke 'resque:restart'
  end
end
