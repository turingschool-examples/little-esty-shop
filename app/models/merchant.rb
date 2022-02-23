class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def merchant_invoices
    (invoices.order(:id)).uniq
  end

  def enabled_status
    self.items.where("item_status =?", 1)
  end

  def disabled_status
    self.items.where("item_status =?", 2)
  end
end
