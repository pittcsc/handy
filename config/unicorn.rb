preload_app true
worker_processes 2
timeout 30

check_client_connection true

listen '/u/apps/handy/shared/sockets/unicorn.sock', backlog: 2048
pid '/u/apps/handy/shared/pids/unicorn.pid'
stderr_path '/u/apps/bcx/shared/log/unicorn.log'
stdout_path '/u/apps/bcx/shared/log/unicorn.log'

working_directory '/u/apps/handy/current'

after_fork do |server, worker|
  ActiveRecord::Base.clear_all_connections! if defined?(ActiveRecord::Base)
end
