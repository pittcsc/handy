require 'twilio-ruby'

class MembersController < ApplicationController

  # Disable XSRF protection to allow the Twilio API to make POST requests on the server
  skip_before_action :verify_authenticity_token

  def text_dispatch
    @client = Twilio::REST::Client.new Twilio_Keys[:account_sid], Twilio_Keys[:auth_token]

    number = params[:From]
    body = ""

    if member = Member.find_by(phone: number)
      if member.email
        if event = Event.current
          if Attendance.exists?(:event => event, :member => member)
            body = "You're already marked as present for #{event.name}."
	  else
            body = "Welcome to #{event.name}!"
            attend = Attendance.create(member: member, event: event)
          end
        else
          body = "No event at the moment."
        end
      else
        member.email = params[:Body]
        body = "Okay #{member.first_name}, your email is #{member.email}. Thanks!"
        member.save
        if event = Event.current
          body += "  You've also been marked as here for " + event.name + "."
          body += "  You've also been marked as here for #{event.name}."
          attend = Attendance.create(member: member, event: event)
        end
      end
    else
      name = params[:Body]
      member = Member.create(name: name, phone: number)
      body = "Welcome to the system, #{member.first_name}! Please respond with your email address."
    end

    @client.messages.create(
      :from => Twilio_Keys[:phone_number],
      :to => number,
      :body => body
    )
  end
end
