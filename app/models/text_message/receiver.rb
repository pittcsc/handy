class TextMessage::Receiver
  attr_reader :text_message
  delegate :respond, to: :text_message

  def self.for(text_message)
    if text_message.member.present?
      TextMessage::Receivers::AttendanceReceiver.new(text_message)
    else
      TextMessage::Receivers::RegistrationReceiver.new(text_message)
    end
  end

  def initialize(text_message)
    @text_message = text_message
  end

  def receive
    raise NotImplementedError, "Subclasses of TextMessage::Receiver must implement receive"
  end

  protected
    def with_active_event_by_token
      if event = Event.active.find_by_token(text_message.body.downcase)
        yield event
      else
        respond "Oops! That doesn't look like a valid event code."
      end
    end
end
