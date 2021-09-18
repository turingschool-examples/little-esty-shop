class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five_with_count
    joins(invoices: :transactions).where(transactions: {result: 'success'}).
      select('customers.*, COUNT(transactions.*) as t_count').
      order(Arel.sql('COUNT(transactions.*) DESC')).
      group(:id).
      limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
