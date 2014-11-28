class Member < ActiveRecord::Base
  has_many :attendances, dependent: :destroy

  def first_name
    name.to_s.strip.split(/\s+/, 2).first
  end
end
