class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
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
  end

private
# Helper Methods
  def helpers
  ActionController::Base.helpers
  end
end
