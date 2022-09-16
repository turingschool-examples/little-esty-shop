class Customer < ApplicationRecord
  has_many :invoices

  def name
    "#{first_name} #{last_name}"
  end

  def self.top_five_cust
    top_5 = Customer.joins(invoices: [:transactions])
                    .where('transactions.result = 0')
                    .limit(5)
                    .group(:customer_id)
                    .order('count_transactions_id desc')
                    .count('transactions.id')
    top_5.transform_keys { |id| Customer.find(id) }
  end
end
