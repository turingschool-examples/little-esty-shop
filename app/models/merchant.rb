class Merchant < ApplicationRecord
  has_many :items

  has_many :invoice_items, through: :items
   has_many :invoices, through: :invoice_items
   has_many :customers, through: :invoices
   has_many :transactions, through: :invoices

   def customers_list
     customers.distinct
   end

   def top_five_customers
      #need customers, invoices, transactions

       customers.joins(invoices: :transactions).where(transactions:{result: 1})
       .select("customers.*, COUNT(transactions.*) AS trans_count")
       .group("customers.id")
       .order(trans_count: :desc)
       .limit(5)
   end

end
