Resque.redis = Redis.new(Rails.application.config_for('redis/resque'))
Resque.redis.namespace = "resque:handy:#{Rails.env}"
