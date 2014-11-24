preload_app true
worker_processes 1
timeout 30

check_client_connection true

listen '/u/apps/handy/shared/sockets/unicorn.sock', backlog: 2048
pid '/u/apps/handy/shared/pids/unicorn.pid'
stderr_path '/u/apps/handy/shared/log/unicorn.log'
stdout_path '/u/apps/handy/shared/log/unicorn.log'

working_directory '/u/apps/handy/current'

before_fork do |server, worker|
  # For each worker spawned by a new master process, kill off one of the old master's workers.
  # When the last new worker is spawned, kill the old master. Facilitates hot restarts.
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      signal = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(signal, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  # Give processes nice titles.
  revision = File.read('/u/apps/handy/current/REVISION').slice(0, 6)
  $0 = ENV['UNICORN_PROCTITLE'] = "handy-#{revision} ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

  # Close DB connections. No need for processes to hold open connections.
  ActiveRecord::Base.clear_all_connections!
end
