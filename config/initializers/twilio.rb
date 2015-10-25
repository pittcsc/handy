require 'twilio-ruby'

Rails.configuration.x.twilio = Rails.application.config_for(:twilio).symbolize_keys

Twilio.configure do |config|
  config.account_sid = Rails.configuration.x.twilio[:account_sid]
  config.auth_token = Rails.configuration.x.twilio[:auth_token]
end
