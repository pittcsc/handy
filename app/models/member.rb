class Member < ActiveRecord::Base
  def first_name
    self.name.strip.split(/\s+/, 2)[0]
  end
end
