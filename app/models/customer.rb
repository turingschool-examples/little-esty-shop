class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices

  def self.favorite_customers(merchant_id)
    Customer.select(:id, :first_name, :last_name, "count(transactions.*) as transac_count")
      .joins(invoices: :transactions)
      .where("transactions.result = 0")
      .where("invoices.id IN (?)", (Invoice.select(:id).joins(:items).where("merchant_id = ?", merchant_id).distinct.pluck(:id)))
      .group(:id)
      .order("transac_count DESC")
      .limit(5)
  end

  def self.top_five_overall_cust
    Customer.select("customers.*", "count(transactions.*) as transac_count")
    .joins(invoices: :transactions)
    .where("transactions.result = 0")
    .group(:id)
    .order("transac_count DESC")
    .limit(5)
  end

end