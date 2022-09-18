require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'item_best_day' do
    it 'returns created_at date of the invoice with most sales. Most sales defined as largest invoice_item revenue)' do
      customer = Customer.create!(first_name: "Kanye", last_name: "Banjo")

      merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
      merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

      item_ski = merchant_stephen.items.create!(name: "Ski", description: "fast skis", unit_price: 10) 
      item_bike = merchant_stephen.items.create!(name: "Bike", description: "danger bike", unit_price: 10)
      item_climbing_shoes = merchant_stephen.items.create!(name: "Climbing Shoes", description: "fun shoes", unit_price: 10) 
      item_snowboard = merchant_stephen.items.create!(name: "Snowboard", description: "slow board", unit_price: 10) 
      item_rock = merchant_stephen.items.create!(name: "Rock", description: "a good rock", unit_price: 10) 

      item_toothpaste = merchant_stephen.items.create!(name: "Toothpaste", description: "The worst toothpaste you can find", unit_price: 10 )
      item_bowling_shoes = merchant_stephen.items.create!(name: "Bowling Shoes", description: "not fun shoes", unit_price: 10)
      item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 10)

      invoice1 = customer.invoices.create!(status: 1, created_at: '2012-03-27')
      invoice2 = customer.invoices.create!(status: 1, created_at: '2012-03-20')

      invoice3 = customer.invoices.create!(status: 1, created_at: '2013-04-27')
      invoice4 = customer.invoices.create!(status: 1, created_at: '2013-04-20')

      invoice5 = customer.invoices.create!(status: 1, created_at: '2014-04-27')
      invoice6 = customer.invoices.create!(status: 1, created_at: '2014-04-20')

      transaction1 = invoice1.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction2 = invoice2.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction3 = invoice3.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction4 = invoice4.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction5 = invoice5.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction6 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction7 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 1)
      
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_ski.id, quantity: 1000, unit_price: 10)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_ski.id, quantity: 950, unit_price: 10)

      invoice_item3 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item_bike.id, quantity: 900, unit_price: 10)
      invoice_item4 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item_bike.id, quantity: 800, unit_price: 10)

      invoice_item5 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item_snowboard.id, quantity: 700, unit_price: 10)
      invoice_item6 = InvoiceItem.create!(invoice_id: invoice6.id, item_id: item_snowboard.id, quantity: 600, unit_price: 10)

      expect(item_ski.item_best_day).to eq("03/27/12")
      expect(item_bike.item_best_day).to eq("04/27/13")
    end
  end

end
