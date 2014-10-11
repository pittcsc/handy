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
      @client ||= Twilio::REST::Client.new
    end
end
