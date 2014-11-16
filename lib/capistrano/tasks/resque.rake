namespace :resque do
  desc "Restart Resque"
  task :restart do
    on roles(:app) do
      execute '/bin/bash -lc "eye restart handy:resque"'
    end
  end
end
