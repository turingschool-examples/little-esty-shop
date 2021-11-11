class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def successful_transactions_count
    invoice_ids = invoices.pluck(:id)
    Transaction.successful_transactions(invoice_ids)
  end

  def self.top_five_customers
    joins(invoices: :transactions)
    .where(transactions: {result: :success})
    .group("customers.id")
    .select("customers.*, COUNT(*) AS count")
    .order(count: :desc)
    .limit(5)
  end

  def self.top_customers(merchant)
    joins(invoices: [:transactions, {items: :merchant}])
            .where(transactions: {result: :success}, merchants: {id: merchant.id})
            .group(:id)
            .order("transactions.count DESC")
            .limit(5)
  end
end
