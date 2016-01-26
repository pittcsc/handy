Twilio.configure do |config|
  config.account_sid = ENV.fetch('TWILIO_ACCOUNT_SID')
  config.auth_token = ENV.fetch('TWILIO_AUTH_TOKEN')
end

Rails.application.configure do
  config.x.twilio.phone_number = ENV.fetch('TWILIO_PHONE_NUMBER')
end
