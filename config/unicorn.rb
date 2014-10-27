preload_app true
worker_processes 1
timeout 30

check_client_connection true

listen '/u/apps/handy/shared/sockets/unicorn.sock', backlog: 2048
pid '/u/apps/handy/shared/pids/unicorn.pid'
stderr_path '/u/apps/handy/shared/log/unicorn.log'
stdout_path '/u/apps/handy/shared/log/unicorn.log'

working_directory '/u/apps/handy/current'

# When a new master process is forked, kill off the old one. Facilitates hot restarts.
before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  # Give processes nice titles.
  revision = File.read('/u/apps/handy/current/REVISION').slice(0, 6)
  ENV['UNICORN_PROCTITLE'] = "handy-#{revision}"
  $0 = ENV['UNICORN_PROCTITLE']

  # Close DB connections. No need for processes to hold open connections.
  ActiveRecord::Base.clear_all_connections!
end
