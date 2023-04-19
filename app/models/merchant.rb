class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: { disabled: 0, enabled: 1 }

  def top_5_customers
    customers.top_customers
  end
  
  def top_5_items
    items.select("items.*, unit_price * count(*) AS revenue, mode() within group (order by invoices.created_at desc) AS most_sales_day")
    .left_outer_joins(invoice_items: :invoice)
    .group("items.id").
    order("revenue desc").limit(5)
  end

  def status_update(new_status)
    self.status = new_status
    self.save
  end

  def self.enabled_merchants
    where(status: "enabled")
  end

  def self.disabled_merchants
    where(status: "disabled")
  end

  def self.top_5_merchants
    joins(:transactions)
    .where(transactions: { result: "success" })
    .group(:id)
    .select('merchants.*, SUM(unit_price) as revenue')
    .order('revenue DESC')
    .limit(5)
  end

  def high_rev_day
    invoices.joins(:items)
    .group(:id, :created_at).order("SUM(items.unit_price) desc, created_at desc").first.created_at
  end
end