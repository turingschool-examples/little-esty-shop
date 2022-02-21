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

  def not_shipped
    invoice_items.where("status != 2").order("created_at desc")
  end

  def top_five
    binding.pry
    customers.order(Customer.transactions.where(result: 0).count).limit(5)
  end
end
