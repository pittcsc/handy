module TextMessage::Receivable
  class AttendanceReceiver < Receiver
    def self.accept?(text_message)
      text_message.member.present?
    end

    def receive
      with_active_event_by_token do |event|
        mark_sender_as_present_at event
        respond "Thanks, #{text_message.member.first_name}. You're checked in for #{event.name}."
      end
    end

    private
      def mark_sender_as_present_at(event)
        event.attendances.find_or_create_by!(member: text_message.member)
      end
  end
end
