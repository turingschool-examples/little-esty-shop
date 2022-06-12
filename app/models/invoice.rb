class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates :status, presence: true

  enum status: {'cancelled' => 0, 'in progress' => 1, 'completed' => 2}

  def invoice_customer
    "#{customer.first_name} #{customer.last_name}"
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: 1})
    .distinct
    .order(:created_at)
  end

  def self.invoices_with_merchant_items(merchant)
    merchant.invoices.distinct(:id)
  end

  def total_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_revenue
    discount =
    invoice_items
    .joins(:discounts)
    .where('invoice_items.quantity >= discounts.quantity_threshold')
    .select('invoice_items.id, max((discounts.percentage) * (invoice_items.quantity * invoice_items.unit_price)) AS discounted') # SUM(percent_discount * (quantity * price))/100
    .group('invoice_items.id')
    .sum(&:discounted)/100

    total_revenue - discount
  end
end
