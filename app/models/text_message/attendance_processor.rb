class TextMessage
  class AttendanceProcessor < Processor
    def process
      with_active_event_by_token do |event|
        create_attendance event
      end
    end

    private
      def create_attendance(event)
        event.attendances.find_or_create_by!(member: member)

        # Make sure the user is marked as a member of each organization whose
        # event they are at
        event.organizations.each do |o|
          Membership.find_or_create_by!(member: member, organization: o)
        end

        respond "Thanks, #{member.first_name}. You're checked in for #{event.name}."
      end
  end
end
