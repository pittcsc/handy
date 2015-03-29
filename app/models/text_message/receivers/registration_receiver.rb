module TextMessage::Receivers
  class RegistrationReceiver < TextMessage::Receiver
    delegate :registration, to: :text_message

    def receive
      if registration
        continue_registration
      else
        start_new_registration
      end
    end

    private
      def start_new_registration
        with_active_event_by_token do |event|
          event.registrations.create!(phone_number: text_message.phone_number)
          respond "It looks like this is your first time checking in. What's your name?"
        end
      end

      def continue_registration
        if registration.name.blank?
          registration.update!(name: text_message.body)
          respond "Thanks! One last question: what's your email address?"
        else
          registration.update!(email_address: text_message.body)
          registration.complete
          respond "All set! You're checked in for #{registration.event.name}."
        end
      end
  end
end
