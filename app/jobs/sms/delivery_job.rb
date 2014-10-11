class Sms::DeliveryJob < ActiveJob::Base
  def perform(phone_number, body)
    client.messages.create(
      from: Rails.configuration.x.twilio[:phone_number],
      to: phone_number,
      body: body
    )
  end
 
  private
    def client
      @client ||= Twilio::REST::Client.new account_sid, auth_token
    end

    def account_sid
      Rails.configuration.x.twilio[:account_sid]
    end

    def auth_token
      Rails.configuration.x.twilio[:auth_token]
    end
end
