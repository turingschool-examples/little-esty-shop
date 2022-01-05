class Merchant < ApplicationRecord
  has_many :items 

  # def favorite_customers 
  #   # get items for the merchant_id
  #   # get invoice_items with this item id
  #   # get invoice id from invoice_items
  #   # look up transactions and customers with the invoice_id
  #   require "pry"; binding.pry
  #   joins({items: :invoice_items}).where(merchants: { merchant_id: self.id } )
  # end
end
