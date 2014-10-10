require 'twilio-ruby'

class InboundMessageProcessor

  def intialize(phone_number, body)
    @phone_number = phone_number
    @body = body
  end

  def process
    if member
      if member.email
        create_attendance_for_current_event
      else
        update_member_email
      end
    else
      create_member
    end
  end

  private
    def client
      @client ||= Twilio::REST::Client.new
    end

    def member
      @member ||= Member.find_by(phone: @phone_number)
    end

    def event
      @event ||= Event.where(token: event_token).current
    end

    def event_token
      @body.strip.downcase
    end

    def create_attendance_for_event
      if event
        unless Attendance.exists?(event: event, member: member)
          Attendance.create(member: member, event: event)
        end

        respond "Welcome to #{event.name}!"
      else
        respond "Invalid event code."
      end
    end

    def update_member_email
      Member.update!(email: @body)
      respond "Thanks, #{member.first_name}! Your email was updated to #{@body}."
    end

    def create_member
      Member.create!(phone: @phone_number, name: @body)
      respond "Hey there, #{member.first_name}!  Welcome to Handy.  Please respond with your email address."
    end

    def respond(response)
      client.messages.create(
        from: Rails.configuration.x.twilio[:phone_number],
        to: phone_number,
        body: @body
      )
    end
end
