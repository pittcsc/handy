module TextMessage::Receivable
  class AttendanceReceiver < Receiver
    delegate :member, to: :text_message

    def self.accept?(text_message)
      text_message.member.present?
    end

    def receive
      with_active_event_by_token do
        mark_member_as_present
        respond "Thanks, #{member.first_name}. You're checked in for #{active_event_by_token.name}."
      end
    end

    private
      def mark_member_as_present
        active_event_by_token.attendances.find_or_create_by!(member: member)
      end
  end
end
