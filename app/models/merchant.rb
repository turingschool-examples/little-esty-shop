class Merchant < ApplicationRecord

enum status: [:disable, :enable]

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
end
