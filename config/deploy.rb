

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

# Unicorn
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :unicorn_config_path, "#{current_path}/config/unicorn.rb"

namespace :deploy do
  after :publishing, :restart

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
