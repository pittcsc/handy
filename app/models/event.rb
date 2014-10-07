class Event < ActiveRecord::Base
  before_save :ensure_one_current
  has_many :attendances

  before_validation :generate_token, on: :create

  validates :token, presence: true, uniqueness: true

  def self.current
    find_by_current true
  end

  private
    def ensure_one_current
      if current_changed? && current?
        self.class.current.try(:update!, current: false)
      end
    end

    def generate_token
      self.token = SecureRandom.hex(3)
    end
end
