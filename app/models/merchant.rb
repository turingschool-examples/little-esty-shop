class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customer
    #Customer.joins(:items).where("items.merchant_id = #{self.id}").distinct
  end
end
# def top_5_customers
# customers.joins(:transactions)
# .where(transactions: {result: 'success'})
# .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
# .group("customers.id")
# .order("transaction_count desc").limit(5)
# end