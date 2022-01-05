class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true

  def invoice_finder
    Invoice.joins(:invoice_items => :item).where(:items => {:merchant_id => self.id})
  end

  def top_customers(customer_count = 5)
    # edge case, don't show more customers than exists
    if customer_count > self.customers
      customer_count = self.customers
    end

    # Get completed transactions grouped by customer.
    # Order desc by count of completed transactions
    # Limit to customer_count
    require "pry"; binding.pry
    self.invoices.join()

  end
end
