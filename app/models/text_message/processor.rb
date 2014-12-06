class TextMessage::Processor
  attr_reader :text_message
  delegate :member, to: :text_message

  def self.process(text_message)
    new(text_message).process
  end

  def initialize(text_message)
    @text_message = text_message
  end

  def process
    raise NotImplementedError, "Subclasses of TextMessage::Processor must implement process"
  end

  protected
    def with_active_event_by_token
      if active_event_by_token
        yield active_event_by_token
      else
        reject_invalid_event_token
      end
    end

    def respond(response_body)
      text_message.respond_later(response_body)
    end

  private
    def active_event_by_token
      @active_event_by_token ||= Event.active.find_by_token(text_message.body.downcase)
    end

    def reject_invalid_event_token
      respond "Oops! That doesn't look like a valid event code."
    end
end
