class Merchant < ApplicationRecord
  validates_presence_of :name
  #status?
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.top_five_by_successful_transaction
    joins(:invoices, :transactions, :invoice_items).group(:id).select('merchants.*,sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue').where('transactions.result
  = ?', 0).order(total_revenue: :desc).limit(5)
  end
end
