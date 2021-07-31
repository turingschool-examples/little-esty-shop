class Merchant < ApplicationRecord
  has_many :items

  def enable
    self.update(status: true)
  end

  def disable
    self.update(status: false)
  end

  def self.group_by_enabled
    Merchant.where('status = ?', true)
  end

  def self.group_by_disabled
    Merchant.where('status = ?', false)
  end
end
