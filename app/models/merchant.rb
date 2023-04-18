class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    customers.joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
    .group("customers.id")
    .order(transaction_count: :desc).limit(5)
  end
  
  def top_5_items
    items.select("items.*, unit_price * count(*) AS revenue, mode() within group (order by invoices.created_at desc) AS most_sales_day")
    .left_outer_joins(invoice_items: :invoice)
    .group("items.id").
    order("revenue desc").limit(5)
  end
end