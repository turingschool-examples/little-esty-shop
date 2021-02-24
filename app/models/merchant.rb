class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def top_five_customers
    binding.pry
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).group("items.id", "customer_id").count.limit(5)
    # the above statement got me error messages bc items.id HAD to be in the group by or an aggregate function
    # (PG::GroupingError: ERROR:  column "items.id" must appear in the GROUP BY clause or be used in an aggregate function)
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).order('customer_id desc').limit(5) working better but wrong

    # merch = Merchant.find(1)
    # BEST ANSWER SO FAR
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).group("customer_id").count
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).joins(invoices: :customer).group("first_name").count
    # think this answer below confirms it
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).where(invoices: {customer_id: 170}).count

    # needs customer name instead of id, filtered for top 5 already
    # merch.items.joins(invoices: :transactions).where(transactions: {result: "success"}).joins(invoices: :customer).group("customer_id").count.sort_by{|k, v| -v}[0..4]
  end
endg
