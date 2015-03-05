class Registration < ActiveRecord::Base
  belongs_to :event

  def complete
    transaction do
      Member.create!(name: name, phone: phone_number, email: email_address) do |member|
        member.attendances << event.attendances.build
        event.organizations.each do |o|
          Membership.find_or_create_by!(member: member, organization: o)
        end
      end

      destroy!
    end
  end
end
