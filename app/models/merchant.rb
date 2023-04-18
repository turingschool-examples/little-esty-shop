class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  
  enum status: ["disabled", "enabled"]

  scope :enabled_merchants, -> { where(status: 1) }
  scope :disabled_merchants, -> { where(status: 0) }

  def top_five_customers
    Customer.select('customers.*, COUNT(transactions.id) as transaction_count')
           .joins(invoices: [:transactions, :invoice_items => :item])
           .where("items.merchant_id = ? AND transactions.result = ?", self.id, 1)
           .group('customers.id')
           .order('transaction_count DESC')
           .limit(5)
  end

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
            .where("transactions.result = 1")
            .group("invoices.id")
            .sum('invoice_items.unit_price * invoice_items.quantity')
            .values
            .sum
  end

  def self.top_five_merchants
          joins(invoices: [:transactions, :invoice_items])
          .where("transactions.result = 1")
          .group("merchants.id")
          .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
          .order('total_revenue DESC')
          .limit(5)
          
  end

  def update_status(status_update)
    update(status: status_update)
    save   
  end
  def top_day
    invoices.joins(:transactions, :invoice_items)
            .where("transactions.result = 1")
            .group("invoices.id")
            .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) As total_revenue')
            .order('total_revenue DESC')
            .first.created_at
            .strftime("%m/%d/%Y")
    
  end
end