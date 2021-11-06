class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def self.enabled?
    where(status: true)
  end

  def self.disabled?
    where(status: false)
  end
end
