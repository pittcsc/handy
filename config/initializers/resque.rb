require 'resque/server'

Resque.redis = Redis.new(Rails.application.config_for('redis/resque'))
Resque.redis.namespace = "resque:handy:#{Rails.env}"

# Allow admins to access the Resque web interface.
Resque::Server.use(Rack::Auth::Basic) do |email_address, password|
  User.admin.authenticate(email_address, password)
end
