class Attendance < ActiveRecord::Base
  belongs_to :member, required: true
  belongs_to :event, required: true, touch: true

  after_create: :save_memberships

  private

  def save_memberships
    self.event.organizations.each do |o|
      Membership.find_or_create-by!(member: self.member, organization: o)
    end
  end
end
