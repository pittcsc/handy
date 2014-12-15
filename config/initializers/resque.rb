require 'resque/server'

# Use an environment-specific Redis namespace.
Resque.redis.namespace = "resque:handy:#{Rails.env}"

# Allow admins to access the Resque web interface.
Resque::Server.use(Rack::Auth::Basic) do |email_address, password|
  User.admin.authenticate(email_address, password)
end
