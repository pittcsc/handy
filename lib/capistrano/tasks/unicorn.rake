namespace :unicorn do
  desc "Restart Unicorn"
  task :restart do
    on roles(:app) do
      execute "bluepill handy restart unicorn"
    end
  end
end
