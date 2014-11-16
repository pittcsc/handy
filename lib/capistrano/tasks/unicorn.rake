namespace :unicorn do
  desc "Restart Unicorn"
  task :restart do
    on roles(:app) do
      execute '/bin/bash -lc "eye restart handy:unicorn"'
    end
  end
end
