class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items

  enum status: ['in progress', 'cancelled', 'completed']

  # Instance Methods
  def created_at_formatted
    created_at.strftime("%A, %B %-d, %Y")
  end

  def customer_full_name
    self.customer.first_name + ' ' + self.customer.last_name
  end

  def total_revenue
    invoice_items.sum(:unit_price)
  end
end
