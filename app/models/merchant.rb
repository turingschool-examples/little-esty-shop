class Merchant < ApplicationRecord

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

enum status: [:disable, :enable]

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
end
