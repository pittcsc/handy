namespace :resque do
  desc "Restart Resque"
  task :restart do
    on roles(:app) do
      execute "bluepill handy restart resque"
    end
  end
end
