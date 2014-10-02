class Event < ActiveRecord::Base
  before_save :ensure_one_current
  has_many :attendances

  def self.current
    find_by_current true
  end

  private
    def ensure_one_current
      if current_changed? && current?
        self.class.current.try(:update!, current: false)
      end
    end

end
