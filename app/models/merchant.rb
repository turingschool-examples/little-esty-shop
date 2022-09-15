class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def merchant_invoices
    binding.pry
    Invoice.joins(:invoice_items)
  end
end

# .joins(items: :merchant).where