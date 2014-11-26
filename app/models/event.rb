class Event < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :member 
  has_many :registrations, dependent: :destroy
  has_many :ownerships, class_name: 'EventOwnership'
  has_many :organizations, through: :ownerships

  before_validation :generate_unique_token, on: :create
  validates :token, presence: true, uniqueness: true

  validates :name, presence: true
  validates :date, presence: true

  def self.current
    where current: true
  end

  private
    def generate_unique_token
      100.times do
        self.token = Dictionary.sample(2).join(' ')
        return unless self.class.find_by_token(token)
      end

      raise "Couldn't generate unique token for event in 100 tries"
    end
end
