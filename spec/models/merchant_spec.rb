require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  # describe 'Class Methods' do
  #   it 'returns the top 5 merchants' do
  #     # merchant_1 = Merchant.create!(name: "Billy the Guy", status: "enabled")
  #     # merchant_2 = Merchant.create!(name: "Different Guy")
  #     # merchant_3 = Merchant.create!(name: "Christian")
  #     # merchant_4 = Merchant.create!(name: "Braxton")
  #     # merchant_5 = Merchant.create!(name: "Alastair")
  #     # merchant_6 = Merchant.create!(name: "Anthony")

  #     # customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
  #     # customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
  #     # customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
  #     # customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
  #     # customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
  #     # customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")

  #     # invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id)
  #     # invoice_2 = Invoice.create!(status: 1, customer_id: customer_2.id)
  #     # invoice_3 = Invoice.create!(status: 1, customer_id: customer_3.id)
  #     # invoice_4 = Invoice.create!(status: 1, customer_id: customer_4.id)
  #     # invoice_5 = Invoice.create!(status: 1, customer_id: customer_5.id)
  #     # invoice_6 = Invoice.create!(status: 1, customer_id: customer_1.id)
  #     # invoice_7 = Invoice.create!(status: 1, customer_id: customer_1.id)
  #     # invoice_8 = Invoice.create!(status: 1, customer_id: customer_2.id)
  #     # invoice_9 = Invoice.create!(status: 1, customer_id: customer_2.id)
  #     # invoice_10 = Invoice.create!(status: 1, customer_id: customer_3.id)
  #     # invoice_11 = Invoice.create!(status: 1, customer_id: customer_5.id)
  #     # invoice_12 = Invoice.create!(status: 1, customer_id: customer_6.id)
  #     # invoice_13 = Invoice.create!(status: 1, customer_id: customer_6.id)

  #     # item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: merchant_1.id)
  #     # item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: merchant_2.id)
  #     # item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: merchant_3.id, status: 1)
  #     # item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: merchant_4.id, status: 1)
  #     # item_5 = Item.create!(name: "Stretch Armstrong", description: "Stretchy", unit_price: 100, merchant_id: merchant_5.id, status: 1)
  #     # item_6 = Item.create!(name: "Yu-Gi-Oh Cards", description: "It's time to duel", unit_price: 1000, merchant_id: merchant_6.id, status: 1)

  #     # InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: item_1.id, invoice_id: invoice_1.id) # 20000
  #     # InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: item_2.id, invoice_id: invoice_2.id) # 800
  #     # InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: item_3.id, invoice_id: invoice_3.id) # 3200
  #     # InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: item_4.id, invoice_id: invoice_4.id) # 80000
  #     # InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: item_5.id, invoice_id: invoice_5.id) # 500
  #     # InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: item_6.id, invoice_id: invoice_6.id) # 12500
      
      # transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_1.id)
      # transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_2.id)
      # transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_3.id)
      # transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_4.id)
      # transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_5.id)
      # transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: invoice_6.id)

  #     expect(Merchant.top_five_merchants).to eq([@merchant_4, @merchant_1, @merchant_6, @merchant_3, @merchant_2])
  #     expect(Merchant.top_five_merchants).to_not include(@merchant_5)
  #   end
  # end


  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
    @merchant_3 = Merchant.create!(name: "Christian")
    @merchant_4 = Merchant.create!(name: "Braxton")
    @merchant_5 = Merchant.create!(name: "Alastair")
    @merchant_6 = Merchant.create!(name: "Anthony")

    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
    @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
    @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")
    @customer_7 = Customer.create!(first_name: "Donald", last_name: "Duck")
    @customer_8 = Customer.create!(first_name: "Goofy", last_name: "Dog")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: '2001-01-01 00:00:00')
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2002-01-01 00:00:00')
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: '2003-01-01 00:00:00')
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: '2004-01-01 00:00:00')
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2005-01-01 00:00:00')
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id, created_at: '2006-01-01 00:00:00')
    @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_7.id, created_at: '2007-01-01 00:00:00')
    @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: '2008-01-01 00:00:00')
    @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2009-01-01 00:00:00')
    @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2010-01-01 00:00:00')
    @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: '2011-01-01 00:00:00')
    @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: '2012-01-01 00:00:00')
    @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2013-01-01 00:00:00')
    @invoice_14 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2014-01-01 00:00:00')
    @invoice_15 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2015-01-01 00:00:00')
    @invoice_16 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2016-01-01 00:00:00')
    @invoice_17 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2017-01-01 00:00:00')
    @invoice_18 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2018-01-01 00:00:00')
    @invoice_19 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2019-01-01 00:00:00')
    @invoice_20 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2020-01-01 00:00:00')
    @invoice_21 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2021-01-01 00:00:00')
    @invoice_22 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2022-01-01 00:00:00')
    @invoice_23 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2023-01-01 00:00:00')
    @invoice_24 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '1999-01-01 00:00:00')

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: @merchant_3.id, status: 1)
    @item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: @merchant_4.id, status: 1)
    @item_5 = Item.create!(name: "Stretch Armstrong", description: "Stretchy", unit_price: 100, merchant_id: @merchant_5.id, status: 1)
    @item_6 = Item.create!(name: "Yu-Gi-Oh Cards", description: "It's time to duel", unit_price: 1000, merchant_id: @merchant_6.id, status: 1)
    @item_7 = Item.create!(name: "Things", description: "Things", unit_price: 300, merchant_id: @merchant_1.id, status: 1)
    @item_8 = Item.create!(name: "Soccer Ball", description: "Kick it", unit_price: 2000, merchant_id: @merchant_1.id, status: 1)
    @item_9 = Item.create!(name: "keyboard", description: "Type", unit_price: 100, merchant_id: @merchant_1.id, status: 1)
    @item_10 = Item.create!(name: "Hot Sauce", description: "It's hot", unit_price: 1000, merchant_id: @merchant_1.id, status: 1)
    @item_11 = Item.create!(name: "Barbie Dream House", description: "Barbie Time", unit_price: 4000, merchant_id: @merchant_1.id, status: 1)

    @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    @ii_5 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_7.id)
    @ii_8 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_8.id)
    @ii_9 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_9.id)
    @ii_10 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_10.id)
    @ii_11 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_11.id)
    @ii_12 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_12.id)
    @ii_13 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_13.id)
    @ii_14 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_14.id) 
    @ii_15 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_15.id) 
    @ii_16 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_3.id, invoice_id: @invoice_16.id) 
    @ii_17 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_4.id, invoice_id: @invoice_17.id) 
    @ii_18 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_5.id, invoice_id: @invoice_18.id) 
    @ii_19 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_6.id, invoice_id: @invoice_19.id) 
    @ii_20 = InvoiceItem.create!(quantity: 5, unit_price: 3500, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_20.id)
    @ii_21 = InvoiceItem.create!(quantity: 5, unit_price: 4500, status: "shipped", item_id: @item_8.id, invoice_id: @invoice_21.id)
    @ii_22 = InvoiceItem.create!(quantity: 5, unit_price: 6500, status: "shipped", item_id: @item_9.id, invoice_id: @invoice_22.id)
    @ii_23 = InvoiceItem.create!(quantity: 5, unit_price: 5500, status: "shipped", item_id: @item_10.id, invoice_id: @invoice_23.id)
    @ii_24 = InvoiceItem.create!(quantity: 5, unit_price: 7500, status: "shipped", item_id: @item_11.id, invoice_id: @invoice_24.id)
    # @ii_25 = InvoiceItem.create!(quantity: 5, unit_price: 7500, status: "shipped", item_id: @item_7.id, invoice_id: @invoice_24.id)

    @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: "4654407418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: "4653405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_8.id)
    @transaction_9 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_9.id)
    @transaction_10 = Transaction.create!(credit_card_number: "4654435418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_10.id)
    @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
    @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
    @transaction_14 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_14.id)
    @transaction_15 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_15.id)
    @transaction_16 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_16.id)
    @transaction_17 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_17.id)
    @transaction_18 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_18.id)
    @transaction_19 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_19.id)
    @transaction_20 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_20.id)
    @transaction_21 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_21.id)
    @transaction_22 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_22.id)
    @transaction_23 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_23.id)
    @transaction_24 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_24.id)

  end
  
  describe 'instance_methods' do


    describe '#top_five_customers' do
      it 'can return top 5 customers with most transactions' do
          expect(@merchant_1.top_five_customers).to eq([@customer_8, @customer_2, @customer_5, @customer_1, @customer_3])
          expect(@merchant_1.top_five_customers.length).to eq(5)
      end
    end
    
    describe 'items_ready_to_ship' do
      it 'will list all the items ready to ship' do
        expect(@merchant_1.items_ready_to_ship).to eq([@ii_1, @ii_3, @ii_7, @ii_9, @ii_14])
      end
    end

    describe '#change_status' do
      it 'changes an items status' do
        expect(@merchant_1.status).to eq('disabled')
        
        @merchant_1.change_status
        
        expect(@merchant_1.status).to eq('enabled')

        @merchant_1.change_status
        
        expect(@merchant_1.status).to eq('disabled')
      end
    end

    describe '#top_selling_date' do
      it ' returns the date where the merchant had the best sales' do
        expect(@merchant_1.top_selling_date).to eq("2010-01-01 00:00:00 UTC")
      end
    end
  end


  describe 'Class Methods' do
    it 'returns the top 5 merchants' do
      expect(Merchant.top_five_merchants).to eq([@merchant_1, @merchant_4, @merchant_2, @merchant_6, @merchant_3])
      expect(Merchant.top_five_merchants).to_not include(@merchant_5)
    end
  end

  describe '#top_five_most_popular_items' do
    it 'will list the top five items based on total revenue generated' do
      expect(@merchant_1.top_five_items_by_revenue).to eq([@item_1, @item_11, @item_9, @item_10, @item_8])
    end
  end
end