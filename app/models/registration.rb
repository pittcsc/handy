class Registration < ActiveRecord::Base
  belongs_to :event

  def complete
    transaction do
      Member.create!(name: name, phone: phone_number, email: email_address) do |member|
        member.attendances << event.attendances.build
      end

      destroy!
    end
  end
end
