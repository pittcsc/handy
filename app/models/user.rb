class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :organizations

  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end
