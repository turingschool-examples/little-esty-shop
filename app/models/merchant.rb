class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices,  through: :invoice_items
  # has_many :customers, through: :invoices
  # has_many :transactions, through: :invoices

  validates_presence_of :name

  def merchant_invoice_by_item_id
    # require 'pry'; binding.pry
    InvoiceItem.all.where(item_id: items.ids).pluck(:invoice_id).uniq
  end
end
