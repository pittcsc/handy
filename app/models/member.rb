class Member < ActiveRecord::Base
  has_many :attendance

  def first_name
    name.strip.split(/\s+/, 2).first
  end
end
