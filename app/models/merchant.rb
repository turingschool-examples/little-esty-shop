class Merchant < ApplicationRecord
  has_many :items

  def enable
    self.status = true
  end

  def disable
    self.status = false
  end
end
