class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def invoice_finder
    Invoice.joins(:invoice_items => :item).where(:items => {:merchant_id => self.id})
  end

  def top_customers(customer_count = 5)
    # edge case, don't show more customers than exists
    if customer_count > customers.count
      customer_count = customers.count
    end

    # Get completed transactions grouped by customer.
    # Order desc by count of completed transactions
    # Limit to customer_count

    customer_ids = invoices.where(status: :completed)
            .joins(:customer)
            .group(:customer_id)
            .order(count_customer_id: :desc)
            .limit(customer_count)
            .count(:customer_id)
            .keys
    Customer.find(customer_ids)
  end
  def self.top_customers(customer_count = 5)
    customers = Customer.all
    # edge case, don't show more customers than exists
    if customer_count > customers.count
      customer_count = customers.count
    end

    # Get completed transactions grouped by customer.
    # Order desc by count of completed transactions
    # Limit to customer_count

    customer_ids = Invoice.where(status: :completed)
            .joins(:customer)
            .group(:customer_id)
            .order(count_customer_id: :desc)
            .limit(customer_count)
            .count(:customer_id)
            .keys
    Customer.find(customer_ids)
  end
  #need transaction result = 0
  def self.top_5
    binding.pry
    Customer.joins(:invoices => :transactions)
            .where(:transactions => {result: 0})
            .group(:customer_id)
            .order(count_customer_id: :desc)
            .limit(customer_count)
            .count(:customer_id)
    # trans = Customer.trans
    # Customer.joins(:invoices => trans).where(result: :success)
  end
end
