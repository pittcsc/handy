namespace :unicorn do
  desc "Start Unicorn"
  task :start do
    on roles(:app) do
      execute '/bin/bash -lc "eye start handy:unicorn"'
    end
  end

  desc "Stop Unicorn"
  task :stop do
    on roles(:app) do
      execute '/bin/bash -lc "eye stop handy:unicorn"'
    end
  end

  desc "Restart Unicorn"
  task :restart do
    on roles(:app) do
      execute '/bin/bash -lc "eye restart handy:unicorn"'
    end
  end
end
