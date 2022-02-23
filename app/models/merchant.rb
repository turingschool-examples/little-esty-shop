class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def ship_ready_items
    self.invoice_items.where.not(status: :shipped)
  end

  def customers_list
    customers.distinct
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
     x = items.joins(transactions: [invoice_items: :invoices])
              .where(transactions:{result: 1})
              .select("items.*, invoice_item.unit_price * invoice_item.quantity AS totalrevenue")
              .group("items.id")
              .order(totalrevenue: :desc)
              .limit(5)
   end

end
