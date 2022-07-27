class Merchant < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :created_at
  validates_presence_of :updated_at

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    #                         customers.joins(:transactions).distinct
    #                        .where(transactions: {result: "success"})
    #                        .select("customers.*, COUNT(transactions.*) AS trans_count")
    #                        .group(:id).count(:transactions)
    #                        .sort_by { |id, count| [count, -id] }.reverse
    #                        .first(5)
    #                        .map { |customer_count| customer_count[0] }
    # Customer.find(customer_ids)
    customers.joins(invoices: :transactions)
             .where(transactions:{result: "success"})
             .select("customers.*, COUNT(transactions.*) AS trans_count")
             .group("customers.id")
             .order(trans_count: :desc)
             .limit(5)
            
  end

  
end
