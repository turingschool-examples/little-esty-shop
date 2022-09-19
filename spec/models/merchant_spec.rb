require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
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


  describe 'merchant_invoice_finder' do
    it 'returns invoice ids for invoices that are for at least one of the merchants items' do

      steph_merchant = Merchant.create!(name: "Stephen's shop")
      kev_merchant = Merchant.create!(name: "Kevin's shop")

      customer1 = Customer.create!(first_name: "Abdul", last_name: "Redd")

      item1 = Item.create!(name: "Climbing Chalk", description: "Purest powder on the market", unit_price: 1500, merchant_id: steph_merchant.id) 
      item2 = Item.create!(name: "Colorado Air", description: "Air in a can", unit_price: 2500, merchant_id: steph_merchant.id) 
      item3 = Item.create!(name: "Boulder", description: "It's a literal rock", unit_price: 3500, merchant_id: kev_merchant.id) 

      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )
      invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id, created_at: "2022-08-27 10:00:00 UTC" )

      invoice_item1 = InvoiceItem.create!(quantity:100, unit_price: 1500, status: "pending", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity:100, unit_price: 2500, status: "packaged", item_id: item2.id, invoice_id: invoice2.id)
      invoice_item3 = InvoiceItem.create!(quantity:100, unit_price: 3500, status: "pending", item_id: item3.id, invoice_id: invoice3.id)

      expect(steph_merchant.merchant_invoice_finder).to eq([invoice1, invoice2])
    end
  end

  it 'can find enabled merchants' do
    merchant1 = Merchant.create(name: 'John', status: 'Enabled')
    merchant2 = Merchant.create(name: 'Jill', status: 'Enabled')
    merchant3 = Merchant.create(name: 'Beth', status: 'Disabled')
    merchant4 = Merchant.create(name: 'Kieth', status: 'Disabled')
    expect(Merchant.enabled_merchants).to eq([merchant1, merchant2])
  end

  it 'can find disabled_merchants' do
    merchant1 = Merchant.create(name: 'John', status: 'Enabled')
    merchant2 = Merchant.create(name: 'Jill', status: 'Enabled')
    merchant3 = Merchant.create(name: 'Beth', status: 'Disabled')
    merchant4 = Merchant.create(name: 'Kieth', status: 'Disabled')
    expect(Merchant.disabled_merchants).to eq([merchant3, merchant4])
  end

  it 'can list the top five merchants' do
    merchant1 = create(:merchant, status: 'Enabled')
    merchant2 = create(:merchant, status: 'Enabled')
    merchant3 = create(:merchant, status: 'Enabled')
    merchant4 = create(:merchant, status: 'Enabled')
    merchant5 = create(:merchant, status: 'Enabled')
    merchant6 = create(:merchant, status: 'Enabled')
    merchant7 = create(:merchant, status: 'Enabled')

    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant2.id)
    item3 = create(:item, merchant_id: merchant3.id)
    item4 = create(:item, merchant_id: merchant4.id)
    item5 = create(:item, merchant_id: merchant5.id)
    item6 = create(:item, merchant_id: merchant6.id)
    item7 = create(:item, merchant_id: merchant7.id)

    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice4 = create(:invoice)
    invoice5 = create(:invoice)
    invoice6 = create(:invoice)
    invoice7 = create(:invoice)

    transaction1 = create(:transaction, result: 'success', invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: 'success', invoice_id: invoice2.id)
    transaction3 = create(:transaction, result: 'success', invoice_id: invoice3.id)
    transaction4 = create(:transaction, result: 'success', invoice_id: invoice4.id)
    transaction5 = create(:transaction, result: 'success', invoice_id: invoice5.id)
    transaction6 = create(:transaction, result: 'success', invoice_id: invoice6.id)
    transaction7 = create(:transaction, result: 'failed', invoice_id: invoice7.id)

    invoice_item1 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 1, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 2, item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 3, item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 4, item_id: item4.id, invoice_id: invoice4.id)
    invoice_item5 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 5, item_id: item5.id, invoice_id: invoice5.id)
    invoice_item6 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 6, item_id: item6.id, invoice_id: invoice6.id)
    invoice_item7 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 7, item_id: item7.id, invoice_id: invoice7.id)


    expect(Merchant.top_5_merchants).to eq([merchant6, merchant5, merchant4, merchant3, merchant2])
  end

  it 'can return date with highest sales' do

    @merchant6 = create(:merchant, status: 'Enabled')
    @item6 = create(:item, merchant_id: @merchant6.id)
    @invoice6 = create(:invoice, created_at: Date.new(2022,3,15))
    @invoice8 = create(:invoice, created_at: Date.new(2022,9,17))
    @transaction6 = create(:transaction, result: 'success', invoice_id: @invoice6.id)
    @transaction8 = create(:transaction, result: 'success', invoice_id: @invoice8.id)
    @invoice_item6 = create_list(:invoiceItem, 3, quantity: 3, unit_price: 6, item_id: @item6.id, invoice_id: @invoice6.id)
    @invoice_item8 = create_list(:invoiceItem, 3, quantity: 2, unit_price: 2, item_id: @item6.id, invoice_id: @invoice8.id)

    expect(@merchant6.highest_sales_date).to eq(Date.new(2022,3,15))
  end
end
