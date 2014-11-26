class Access < ActiveRecord::Base
  belongs_to :organization, required: true
  belongs_to :user, required: true
end
