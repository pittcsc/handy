class Membership < ActiveRecord::Base
  belongs_to :member, required: true
  belongs_to :organization, required: true
end
