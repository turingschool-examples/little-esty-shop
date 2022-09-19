require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end


  describe 'Class Methods' do   
    describe '.not_shipped' do 
        it 'sorts by status when not shipped' do
          stephen = Merchant.create!(name: "Stephen's shop")

          customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

          item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: stephen.id) 
          item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: stephen.id) 
          item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: stephen.id) 

          invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
          
          invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
          invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice1.id)
          invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)

          expect(stephen.not_shipped).to eq([item1,item2])
        end 
      end
  describe 'enabled_items' do
    it 'returns items where enabled attribute equals true' do
      merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
      merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

      item_bad_toothpaste = merchant_stephen.items.create!(name: "Bad Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000, enabled: true )
      item_good_toothpaste = merchant_stephen.items.create!(name: "Super Toothpaste", description: "The best toothpaste you can find", unit_price: 4000, enabled: false )

      item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000)

      expect(merchant_stephen.enabled_items).to eq([item_bad_toothpaste])
    end
  end

  describe 'disabled_items' do
    it 'returns items where enabled attribute equals false' do
      merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
      merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

      item_bad_toothpaste = merchant_stephen.items.create!(name: "Bad Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000, enabled: true )
      item_good_toothpaste = merchant_stephen.items.create!(name: "Super Toothpaste", description: "The best toothpaste you can find", unit_price: 4000, enabled: false )

      item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000)

      expect(merchant_stephen.disabled_items).to eq([item_good_toothpaste])
    end
  end

  describe 'top_items' do
    it 'returns the names of the top five items by revenue invoice_item unit price*quantity' do

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

      invoice1 = customer.invoices.create!(status: 1)
      invoice2 = customer.invoices.create!(status: 1)
      invoice3 = customer.invoices.create!(status: 1)
      invoice4 = customer.invoices.create!(status: 1)
      invoice5 = customer.invoices.create!(status: 1)
      invoice6 = customer.invoices.create!(status: 1)
      invoice7 = customer.invoices.create!(status: 1)
      invoice8 = customer.invoices.create!(status: 1)

      transaction1 = invoice1.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction2 = invoice2.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction3 = invoice3.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction4 = invoice4.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction5 = invoice5.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction6 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      transaction7 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 1)
      transaction8 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
      
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_ski.id, quantity: 1000, unit_price: 10)
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_bike.id, quantity: 900, unit_price: 10)
      invoice_item3 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item_climbing_shoes.id, quantity: 800, unit_price: 10)
      invoice_item4 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item_snowboard.id, quantity: 700, unit_price: 10)
      invoice_item5 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item_rock.id, quantity: 600, unit_price: 10)
      invoice_item6 = InvoiceItem.create!(invoice_id: invoice6.id, item_id: item_lamp.id, quantity: 500, unit_price: 10)
      invoice_item7 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_bike.id, quantity: 5000, unit_price: 10)
      invoice_item8 = InvoiceItem.create!(invoice_id: invoice8.id, item_id: item_lamp.id, quantity: 90000, unit_price: 10)

      expect(merchant_stephen.top_items).to eq([item_bike, item_ski, item_climbing_shoes, item_snowboard, item_rock])
    end
  end
end
