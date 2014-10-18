class TextMessage::Processor
  attr_reader :text_message
  delegate :event, :member, :respond, to: :text_message

  def initialize(text_message)
    @text_message = text_message
  end

  protected
    def for_current_event_with_token
      if current_event_with_token
        yield current_event_with_token
      else
        reject_invalid_event_token
      end
    end

  private
    def current_event_with_token
      @current_event_with_token ||= Event.where(token: event_token).current
    end

    def event_token
      text_message.body.downcase
    end

    def reject_invalid_event_token
      respond "Oops! That doesn't look like a valid event code."
    end
end
