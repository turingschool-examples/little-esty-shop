class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_5
    x = items
    .joins(invoices: :transactions)
    require "pry"; binding.pry
    .where("transactions.result = 'success'")

    # .limit(5)

  end
end
