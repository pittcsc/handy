class Member < ActiveRecord::Base
  def nick
    if self.name.include? ' '
      self.name.slice(0..(self.name.index(' ') - 1))
    else
      self.name
    end
  end
end
