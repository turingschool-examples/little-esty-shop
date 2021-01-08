class Merchant < ApplicationRecord
    has_many :invoices
    has_many :customers, through: :invoices
    has_many :items

    def best_customers
      self.invoices.group(:customer_id).where(status: 1).count.sort_by{|k, v| v}.reverse.first(5)
    end
end
