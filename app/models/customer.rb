class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  # Can we use ruby for this method?
  def name
    first_name + " " + last_name
  end

  def self.top_five_customers
    joins(:transactions)
  end
end
