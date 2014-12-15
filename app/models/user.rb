class User < ActiveRecord::Base
  has_secure_password

  has_many :accesses, dependent: :destroy
  has_many :organizations, through: :accesses

  validates :email, presence: true, uniqueness: true

  scope :admin, -> { where(admin: true) }

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end
