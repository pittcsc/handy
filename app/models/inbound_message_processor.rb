require 'twilio-ruby'

class InboundMessageProcessor
  def initialize(phone_number, body)
    @phone_number = phone_number
    @body = body.strip
  end

  def process
    if member
      process_attendance
    else
      process_registration
    end
  end

  private
    def member
      @member ||= Member.find_by(phone: @phone_number)
    end

    def event
      @event ||= Event.where(token: @body.downcase).current
    end

    def registration
      @registration ||= Registration.find_by(phone_number: @phone_number)
    end

    def process_attendance
      if event
        event.attendances.find_or_create_by!(member: member)
        respond "Thanks, #{member.first_name}. You're checked in for #{event.name}."
      else
        reject_invalid_event_token
      end
    end

    def process_registration
      if registration
        continue_existing_registration
      elsif event
        start_new_registration
      else
        reject_invalid_event_token
      end
    end

    def start_new_registration
      event.registrations.create!(phone_number: @phone_number)
      respond "It looks like this is your first time checking in. What's your name?"
    end

    def continue_existing_registration
      if registration.name.blank?
        registration.update!(name: @body)
        respond "Thanks! One last question: what's your email address?"
      else
        registration.update!(email_address: @body)
        registration.complete
        respond "All set! You're checked in for #{registration.event.name}."
      end
    end

    def reject_invalid_event_token
      respond "Oops! That doesn't look like a valid event code."
    end

    def respond(response)
      Sms::DeliveryJob.perform_later(@phone_number, response)
    end
end
