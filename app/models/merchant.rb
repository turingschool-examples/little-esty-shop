class Merchant < ApplicationRecord

enum status: [:disable, :enable]

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def self.new_mechant_id
    all.last.id + 1
  end
end
