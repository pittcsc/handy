class TextMessage::Receivable::Receiver
  attr_reader :text_message
  delegate :respond, to: :text_message

  def self.accept?(text_message)
    true
  end

  def initialize(text_message)
    @text_message = text_message
  end

  def receive
    raise NotImplementedError, "Subclasses of TextMessage::Receiver must implement receive"
  end

  protected
    def active_event_by_token
      @active_event_by_token ||= Event.active.find_by_token(text_message.body.downcase)
    end

    def active_event_by_token?
      active_event_by_token.present?
    end

    def with_active_event_by_token
      active_event_by_token? ? yield : reject_invalid_event_token
    end

    def reject_invalid_event_token
      respond "Oops! That doesn't look like a valid event code."
    end
end
