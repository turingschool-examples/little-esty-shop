class Merchant < ApplicationRecord
  enum status: {Disabled: 0, Enabled: 1}
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_ready_to_ship
    invoice_items.joins(:invoice).where.not(status: 2).order('invoices.created_at')
  end

  def favorite_customers
    customers.joins(invoices: :transactions)
      .where(transactions: { result: 1 })
      .select('customers.*, count(transactions.result) as transaction_total')
      .group(:id)
      .order(transaction_total: :desc)
      .distinct
      .limit(5)      
  end
  
  def enabled_items
    items.where(status: "Enabled")
  end

  def disabled_items
    items.where(status: "Disabled")
  end

  def self.enabled_merchants
    where(status: 'Enabled')
  end
  def self.disabled_merchants
    where(status: 'Disabled')
  end
end

