class EventOwnership < ActiveRecord::Base
  belongs_to :organization, required: true
  belongs_to :event, required: true
end
