class Event < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :registrations, dependent: :destroy

  before_validation :generate_token, on: :create
  validates :token, presence: true, uniqueness: true

  validates :name, presence: true
  validates :date, presence: true

  def self.current
    where current: true
  end

  private
    def generate_token
      counter = 2
      self.token = Dictionary.sample(2).join(' ')

      while Event.find_by_token(self.token)
        self.token = Dictionary.sample(2).join(' ')
        counter -= 1

        if counter == 0
          raise "Can't generate unique token for event."
        end
      end
    end
end
