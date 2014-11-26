class User < ActiveRecord::Base
  has_secure_password
  has_many :accesses
  has_many :organizations, through: :accesses

  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end
