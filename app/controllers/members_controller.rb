require 'twilio-ruby'

class MembersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def text_dispatch
    @client = Twilio::REST::Client.new Twilio_Keys[:account_sid], Twilio_Keys[:auth_token]

    number = params[:From][2..-1]
    body = ""

    member = Member.find_by(phone: number)

    if member
      body = "Welcome back, " + member.name
    else
      name = params[:Body]
      member = Member.create(name: name, phone: number)
      member.save
      body = "Welcome to the system, " + name + "!"
    end

    @client.messages.create(
      :from => '+12162424434',
      :to => '+14407817648',
      :body => body
    )
  end
end
