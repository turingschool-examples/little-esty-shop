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

  def items_ready_ship
    invoice_items.where('invoice_items.status = ?', 1)
  end
end
