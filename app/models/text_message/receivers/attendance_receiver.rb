module TextMessage::Receivers
  class AttendanceReceiver < TextMessage::Receiver
    def receive
      with_active_event_by_token do |event|
        create_attendance event
      end
    end

    private
      def create_attendance(event)
        event.attendances.find_or_create_by!(member: text_message.member)
        respond "Thanks, #{text_message.member.first_name}. You're checked in for #{event.name}."
      end
  end
end
