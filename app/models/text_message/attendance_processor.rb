class TextMessage
  class AttendanceProcessor < Processor
    def process
      for_current_event_with_token do |event|
        create_attendance event
      end
    end

    private
      def create_attendance(event)
        event.attendances.find_or_create_by!(member: member)
        respond "Thanks, #{member.first_name}. You're checked in for #{event.name}."
      end
  end
end
