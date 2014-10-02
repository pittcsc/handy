class Member < ActiveRecord::Base
  has_many :attendance

  def first_name
    self.name.strip.split(/\s+/, 2)[0]
  end
end
