class Invoice < ApplicationRecord
  enum status: { 'in progress' => 0, cancelled: 1, completed: 2 }
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  scope :with_successful_transactions, lambda {
                                         joins(:transactions)
                                           .where('transactions.result =?', 0)
                                       }

  def customer_name
    customer = Customer.find(customer_id)
    customer.first_name + ' ' + customer.last_name
  end

  def pre_discount_revenue
    cents = invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
    format('%.2f', (cents / 100.0))
  end

  def sucessful_transactions
    transactions.where('transactions.result =?', 0)
  end

  def apply_discount
    revenue = 0.00
    invoice_items.each do |item|
      if !item.merchant_discount.nil?
        revenue += item.calculate_discounted_renevue
      elsif item.merchant_discount.nil?
        revenue += item.calculate_renevue
      end
    end
    revenue
  end

  def display_discount_revenue
    cents = apply_discount
    format('%.2f', (cents / 100.0))
  end

  def display_date
    created_at.strftime('%A, %B %d, %Y')
  end

  def self.not_shipped
    joins(:invoice_items)
      .where('invoice_items.status != 2')
      .group(:id)
      .order(created_at: :asc)
      .distinct
  end
end
