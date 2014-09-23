require 'twilio-ruby'

class MembersController < ApplicationController

  # Disable XSRF protection to allow the Twilio API to make POST requests on the server
  skip_before_action :verify_authenticity_token

  def text_dispatch
    @client = Twilio::REST::Client.new Twilio_Keys[:account_sid], Twilio_Keys[:auth_token]

    # I initially set up phone numbers as length 10 strings. Twilio adds a "+1"
    # in front of every number.  Which seems unnecessary to store since in the US,
    # where we're using this, it's universal
    number = params[:From][2..-1]
    body = ""

    member = Member.find_by(phone: number)

    if member
      if member.email
        if CurrentEvent.first
          event = Event.find(CurrentEvent.first.event_id)
          body = "Welcome to " + event.name + "!"
          attend = Attendance.create(member_id: member.id, event_id: event.id)
          attend.save
        else
          body = "No event at the moment."
        end
      else
        member.email = params[:Body]
        body = "Okay " + member.first_name + ", your email is " + member.email + ". Thanks!"
        member.save
        if CurrentEvent.first
          event = Event.find(CurrentEvent.first.event_id)
          body += "  You've also been marked as here for " + event.name + "."
          attend = Attendance.create(member_id: member.id, event_id: event.id)
          attend.save
        end
      end
    else
      name = params[:Body]
      member = Member.create(name: name, phone: number)
      member.save
      body = "Welcome to the system, " + member.first_name + "! Please respond with your email address."
    end

    @client.messages.create(
      :from => '+12162424434',
      :to => '+1' + number,
      :body => body
    )
  end
end
