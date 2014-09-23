class Event < ActiveRecord::Base
  has_many :current_event, :dependent => :delete_all
end
