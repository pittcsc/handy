class TextMessage::Sender
  def self.client
    @@client ||= Twilio::REST::Client.new
  end
  delegate :client, to: :class

  def initialize(text_message)
    @text_message = text_message
  end

  def send
    client.messages.create \
      from: Rails.configuration.x.twilio[:phone_number],
      to: @text_message.phone_number,
      body: @text_message.body
  end
end
