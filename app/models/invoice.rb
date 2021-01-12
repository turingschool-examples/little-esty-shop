class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:"in progress", :completed, :cancelled]

  def self.incomplete
    joins(:invoice_items)
    .where('invoices.status = ? AND invoice_items.status != ?', 0, 2)
    .select("invoices.*, COUNT('invoice_items.status') AS item_count")
    .group(:id)
  end

  def clean_date
    created_at.strftime("%A, %B %m, %Y")
  end

  # def self.happy_customers
  #   where(status: 1).pluck(:customer_id).uniq
  # end
end
