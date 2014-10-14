class Registration < ActiveRecord::Base
  belongs_to :event

  def complete
    transaction do
      member = Member.create!(name: name, phone: phone_number, email: email_address)
      event.attendances.create!(member: member)
      destroy!
    end
  end
end
