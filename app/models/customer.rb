class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def successful_transactions_count
    invoice_ids = self.invoices.pluck(:id)
    Transaction.where(invoice_id: invoice_ids).where(result: 'success').count
  end

  def self.top_five_customers
    joins(invoices: :transactions)
    .where(transactions: {result: :success})
    .group("customers.id")
    .select("customers.*, COUNT(*) AS count")
    .order(count: :desc)
    .limit(5)
  end
end
