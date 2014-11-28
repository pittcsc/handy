class Attendance < ActiveRecord::Base
  belongs_to :member, required: true
  belongs_to :event, required: true
end
