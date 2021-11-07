class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name

  def merchant_invoices
    invoices
  end

  def favorite_customers
    customers.joins(invoices: :transactions)
             .where('transactions.result = ?', 'success')
             .group('customers.id')
             .select('customers.*')
             .order(count: :desc)
             .limit(5)
             .count
  end

  def top_five_items
    var = items.joins(invoices: :transactions)
         .where("transactions.result = 'success'")
         .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
         .group(:id)
         .order('revenue desc')
         .limit(5)
  end

  def self.merchant_status(status)
    where(status: status)
  end

  def self.top_five_merchants
    self.joins(:items)
       .joins(invoices: :transactions)
       .where("transactions.result = 'success'")
       .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
       .group(:id)
       .order('revenue desc')
       .limit(5)
  end

  def self.merchant_best_day
      self.joins(items: :invoices)
        .select('invoices.created_at')
            .group('invoices.created_at')
            .order('created_at desc')
            .first
            .created_at
            .to_date
  end
end
