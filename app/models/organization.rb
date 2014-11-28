class Organization < ActiveRecord::Base
  has_many :accesses, dependent: :destroy
  has_many :users, through: :accesses
  has_many :event_ownerships, dependent: :destroy
  has_many :events, through: :event_ownerships
end
