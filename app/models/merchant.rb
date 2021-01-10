class Merchant < ApplicationRecord
  validates_presence_of :name

  enum status: ['Enabled', 'Disabled']

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  def top_five_customers
    self.transactions.joins(invoice: :customer)
      .where('transactions.result = ?', "success")
      .select('customers.first_name, count(transactions) as successful_transactions')
      .group('customers.id')
      .order('successful_transactions desc')
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items).where.not('invoice_items.status = ?', 2)
  end

  def order_merchant_items_by_invoice_created_date(items)
    items.joins(:invoices).where('invoices.merchant_id = ?', self.id).order('invoices.created_at ASC')
  end
end
