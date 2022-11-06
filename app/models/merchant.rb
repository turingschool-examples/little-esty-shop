class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: {disabled: 0, enabled: 1}

  def top_merchant_transactions
    Customer
      .select('customers.*, count(transactions) as transactions_count')
      .joins(invoices: [:transactions, { items: :merchant }])
      .where("transactions.result = 0 AND merchants.id = #{id}")
      .group('id')
      .order(transactions_count: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    items
      .joins(invoice_items: :invoice)
      .select('items.*, invoices.created_at as invoice_date, invoices.id as invoice_id')
      .where('invoice_items.status = 0 OR invoice_items.status = 1')
      .order(:created_at)
  end

  def self.enabled_merchants
    self.where('status = 1')
  end

  def self.disabled_merchants
    self.where('status = 0')
  end
end
