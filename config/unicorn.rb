preload_app true
worker_processes 1
timeout 30

check_client_connection true

listen '/u/apps/handy/shared/sockets/unicorn.sock', backlog: 2048
pid '/u/apps/handy/shared/pids/unicorn.pid'
stderr_path '/u/apps/handy/shared/log/unicorn.log'
stdout_path '/u/apps/handy/shared/log/unicorn.log'

working_directory '/u/apps/handy/current'

after_fork do |server, worker|
  # Give processes a nice title.
  revision = File.read('/u/apps/handy/current/REVISION').slice(0, 6)
  ENV['UNICORN_PROCTITLE'] = "handy-#{revision}"
  $0 = ENV['UNICORN_PROCTITLE']

  # Close old MySQL connections.
  ActiveRecord::Base.clear_all_connections! if defined?(ActiveRecord::Base)
end
