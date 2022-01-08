class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  enum status: {enable: 0, disable: 1}

  def self.enabled_merchants
    Merchant.where(status: 'enable')
  end

  def self.disabled_merchants
    Merchant.where(status: 'disable')
  end
end
