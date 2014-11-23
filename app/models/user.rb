class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end
