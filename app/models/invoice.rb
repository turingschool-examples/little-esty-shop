class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  belongs_to :customer

  enum status:["in progress", "completed", "cancelled"]

  def total_revenue
    helpers.number_to_currency((self.invoice_items.sum(:unit_price).to_f)/100)
  end

  def self.not_shipped
    # binding.pry
    all
    .joins(:invoice_items)
    .where.not("invoice_items.status = ?", 2)
    .order(created_at: :desc)
  end

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_discounted_revenue


  end

private
# Helper Methods
  def helpers
  ActionController::Base.helpers
  end
end
