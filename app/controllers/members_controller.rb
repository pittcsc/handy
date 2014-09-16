require 'twilio-ruby'

class MembersController < ApplicationController
  def text_dispatch
    @client = Twilio::REST::Client.new Twilio_Keys[:account_sid], Twilio_Keys[:auth_token]

    @client.messages.create(
      :from => '+12162424434',
      :to => '+14407817648',
      :body => 'Twilio Rails test'
    )
  end
end
