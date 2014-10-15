ENV['RESQUE_POOL_CONFIG'] = Rails.root.join('config/resque_pool.yml').to_s

require 'resque/pool/tasks'

task 'resque:pool:setup' do
  revision = File.read('/u/apps/handy/current/REVISION').slice(0, 6) rescue 'missing'
  Resque::Pool.app_name = "handy-#{revision}"

  # Preload the app in master workers.
  Resque::Pool.after_prefork do |job|
    require Rails.root.join('config/environment')
  end

  # Close DB connections before forking a worker.
  Resque.before_fork do
    ActiveRecord::Base.clear_all_connections!
  end
end
