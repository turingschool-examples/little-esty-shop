class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true

  def top_customers
    test = invoices.joins(:customer, :transactions)
                     .where(transactions: {result: true})
                     .select("customers.*, count(transactions.id) as total_count")
                     .group("customers.id, invoice_items.id")
                     .distinct
                     .order(total_count: :desc)
                     .limit(5)
                     binding.pry
    test
  end
end
