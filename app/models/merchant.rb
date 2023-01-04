class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoice_items, through: :items, dependent: :destroy
    has_many :invoices, through: :invoice_items, dependent: :destroy
    has_many :customers, through: :invoices, dependent: :destroy
    has_many :transactions, through: :invoices, dependent: :destroy

  def top_customers
    Customer.joins(:transactions)
            .select(:first_name, :last_name, 'count(transactions.*) as num_transactions')
            .group(:id).where(transactions: { result: "success"})
            .order("num_transactions desc")
            .limit(5)
  end
end