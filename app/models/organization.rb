class Organization < ActiveRecord::Base
  has_many :accesses
  has_many :users, through: :accesses
  has_many :event_ownerships
  has_many :events, through: :event_ownerships
end
