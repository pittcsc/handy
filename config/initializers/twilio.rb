require 'twilio-ruby'

Twilio.configure do |config|
  config.account_sid = Rails.configuration.x.twilio[:account_sid]
  config.auth_token = Rails.configuration.x.twilio[:auth_token]
end
