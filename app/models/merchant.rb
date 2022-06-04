class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_5_customers
    customers.joins(:transactions).where("transactions.result = ?", 0).group("customers.id").select("customers.*, count(transactions) as transaction_count").order("transaction_count desc").limit(5)
  end

  def ordered_not_shipped
    # binding.pry
    invoice_items.joins(:invoice).where.not(status: 2).order("invoices.created_at asc")
  end

  def successful_transactions
    invoices.joins(:transactions).select("invoices.*, transactions.result").where("transactions.result = 0").distinct
  end
end
