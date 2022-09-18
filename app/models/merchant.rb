class Merchant < ApplicationRecord
  has_many :items


  def self.enabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Enabled'}
    # Merchant.all.where(status: 'Enabled')
  end

  def self.disabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Disabled'}
  end
end
