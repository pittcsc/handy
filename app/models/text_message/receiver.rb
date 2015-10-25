class TextMessage::Receiver
  attr_reader :text_message
  delegate :respond, to: :text_message

  class << self
    def for(text_message)
      class_for(text_message).new(text_message)
    end

    def class_for(text_message)
      stack.find { |klass| klass.accept?(text_message) }
    end

    def accept?(text_message)
      true
    end

    def stack
      @stack ||= [ TextMessage::Receivers::AttendanceReceiver, TextMessage::Receivers::RegistrationReceiver ]
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
