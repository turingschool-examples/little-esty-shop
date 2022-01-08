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
    if customer_count > customers.count
      customer_count = customers.count
    end

    customer_ids = Customer.joins(:invoices => :transactions)
                            .where(:transactions => {result: 0})
                            .group(:customer_id)
                            .order(count_customer_id: :desc)
                            .limit(customer_count)
                            .count(:customer_id)
                            .keys
    Customer.find(customer_ids)

  end

  def self.top_customers(customer_count = 5)
    customers = Customer.all
    if customer_count > customers.count
      customer_count = customers.count
    end

    customer_ids = Customer.joins(:invoices => :transactions)
                            .where(:transactions => {result: 0})
                            .group(:customer_id)
                            .order(count_customer_id: :desc)
                            .limit(customer_count)
                            .count(:customer_id)
                            .keys
    Customer.find(customer_ids)
  end

  def items_ready_to_ship
    items.joins(:invoice_items => :invoice)
          .where.not(:invoice_items => {status: 2})
          .order("invoices.created_at asc")
          # this needs to be distinct. If there are two identical items with duplicate invoices and invoice items it repeats.
  end
end
