class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"disabled" => 0, "enabled" => 1}

  validates_presence_of(:name)
  validates_presence_of(:status)

  def ship_ready_items
    invoice_items.joins(:invoice)
                  .where.not(status: 2)
                  .order(:created_at)

  end

  def top_five_customers
    customers.joins(invoices: :transactions)
             .where(transactions:{result: 1})
             .select("customers.*, COUNT(transactions.*) AS trans_count")
             .group("customers.id")
             .order(trans_count: :desc)
             .limit(5)
  end

   def top_five_items
     items.joins(invoice_items: {invoice: :transactions})
         .where(transactions:{result: 1})
         .select("items.*, SUM( invoice_items.unit_price * invoice_items.quantity)  AS totalrevenue")
         .group("items.id")
         .order(totalrevenue: :desc)
         .limit(5)
   end

   def self.top_five_merchants
     joins(items: {invoices: :transactions})
     .where(transactions: {result: 1})
     .select("merchants.*, SUM( invoice_items.unit_price * invoice_items.quantity) AS totalrevenue")
     .group(:id)
     .order(totalrevenue: :desc)
     .limit(5)
   end

   def best_sales_day
     invoices.joins(:invoice_items, :transactions)
             .where(transactions:{result: 1})
             .select("invoices.*, SUM( invoice_items.unit_price * invoice_items.quantity)  AS totalrevenue")
             .group("invoices.id")
             .order(totalrevenue: :desc)
             .first.created_at

   end
end
