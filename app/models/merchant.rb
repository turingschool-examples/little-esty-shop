class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :name

  def top_five_customers
    Customer.select("customers.*, count(distinct transactions) as transaction_count")
            .left_joins(:transactions, :items).group(:id)
            .where('transactions.result = ?', 'success')
            .where('items.merchant_id = ?', self.id)
            .order("transaction_count desc").limit(5)
  end

  def ready_to_ship_items
    items.select("distinct items.*, invoices.created_at as invoice_created_at, invoice_items.invoice_id, invoice_items.status")
         .joins(:invoice_items, :invoices)
         .where("invoice_items.status = ?", "1")
         .where("invoice_items.invoice_id = invoices.id")
         .order("invoices.created_at")
  end

  def self.top_5_by_revenue
    Merchant.left_joins(:transactions)
            .select('merchants.*, sum(invoice_items.unit_price) * sum(invoice_items.quantity) as total_revenue')
            .where('transactions.result = ?', 'success')
            .group(:id)
            .distinct
            .order('total_revenue DESC').limit(5)
  end
end