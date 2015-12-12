# Run background jobs via Sucker Punch in all environments.
Rails.application.configure do
  config.active_job.queue_adapter = :sucker_punch
end
