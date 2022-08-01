class Invoice < ApplicationRecord
  enum status: { cancelled: 0, in_progress: 1, completed: 2 }

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  belongs_to :customer

  def formatted_date
    created_at.strftime('%A, %B %d, %Y')
  end

  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end

  # invoice status 1 or 2, invoice_item status 0 or 1
  def self.invoices_with_items_not_shipped
    temp = self.where.not(status: 0)
    valid_invoices =  temp.distinct.joins(:invoice_items)
                          .where.not("invoice_items.status = 2")
                          .order(created_at: :desc)
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end
end

