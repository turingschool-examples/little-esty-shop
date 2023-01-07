class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: { 'disabled' => 0, 'enabled' => 1}

  def top_five_customers
    customers.joins(invoices: :transactions)
      .where(transactions: { result: "success"})
      .select('customers.*, count(transactions.*) as total_transactions')
      .order(total_transactions: :desc)
      .group('customers.id')
      .limit(5)
  end

  def self.top_five_merchants
    Merchant.joins(invoices: :transactions)
            .where(transactions: {result: "success"}, invoices: {status: 1})
            .group(:id, :name)
            .select(:id, :name, 'sum(invoice_items.unit_price * invoice_items.quantity) as total_rev')
            .order(total_rev: :desc)
            .limit(5)
  end

  def items_ready_to_ship
    invoice_items.joins(:invoice)
    .where.not(status: 2)
    .order("invoices.created_at")
  end


  def change_status
    if self.status == 'disabled'
      self.enabled!
    elsif self.status == 'enabled'
      self.disabled!
    end

  def top_five_items_by_revenue
    items.joins(invoices: :transactions)
    .where(transactions: {result: "success"}, invoices: {status: 1})
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as item_revenue')
    .group('items.id')
    .order(item_revenue: :desc)
    .limit(5)
    
  end
end