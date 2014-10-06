require 'twilio-ruby'

class MembersController < ApplicationController

  # Disable XSRF protection to allow the Twilio API to make POST requests on the server
  skip_before_action :verify_authenticity_token

  def text_dispatch
    @client = Twilio::REST::Client.new Twilio_Keys[:account_sid], Twilio_Keys[:auth_token]

    # I initially set up phone numbers as length 10 strings. Twilio adds a "+1"
    # in front of every number.  Which seems unnecessary to store since in the US,
    # where we're using this, it's universal
    number = params[:From]
    body = ""

    member = Member.find_by(phone: number)

    if member
      if member.email
        event = Event.find_by_current true
        if event
          if Attendance.exists?(:event => event, :member => member)
            body = "You're already marked as present for " + event.name + "."
	  else
            body = "Welcome to " + event.name + "!"
            attend = Attendance.create(member: member, event: event)
            attend.save
          end
        else
          body = "No event at the moment."
        end
      else
        member.email = params[:Body]
        body = "Okay " + member.first_name + ", your email is " + member.email + ". Thanks!"
        member.save
        if Event.find_by_current true
          event = Event.find_by_current(true)
          body += "  You've also been marked as here for " + event.name + "."
          attend = Attendance.create(member: member, event: event)
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
      :from => Twilio_Keys[:phone_number],
      :to => number,
      :body => body
    )
  end
end
