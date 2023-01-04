class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.top5(id)
    binding.pry
    joins(:customers, :transactions)
    .where("transactions.result = 0 AND merchants.id = #{id}")
    .select('customers.*, count(transactions) as success_count')
    .order(success_count: :desc)
  end
end

# customers names, where Transaction