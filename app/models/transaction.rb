class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.total_transactions(customer)
    transactions = joins(invoices: :customers).where(customer_id: customer.id).count
    binding.pry
  end
end
