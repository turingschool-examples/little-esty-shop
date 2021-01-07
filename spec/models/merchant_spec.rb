require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
  #   Merchant.destroy_all
  #   Customer.destroy_all
  #   Transaction.destroy_all
  #   Invoice.destroy_all

    @merchant = create(:merchant)

  #   @customer_1 = create(:customer)
  #   @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
  #   @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
  #   create(:transaction, result: 1, invoice: @invoice_1)
  #   create(:transaction, result: 1, invoice: @invoice_2)

  #   @customer_2 = create(:customer)
  #   @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
  #   @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
  #   create(:transaction, result: 1, invoice: @invoice_3)
  #   create(:transaction, result: 1, invoice: @invoice_3)
  #   create(:transaction, result: 1, invoice: @invoice_3)
  #   create(:transaction, result: 1, invoice: @invoice_4)

  #   @customer_5 = create(:customer)
  #   @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_5)
  #   @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_5)
  #   create(:transaction, result: 1, invoice: @invoice_5)
  #   create(:transaction, result: 1, invoice: @invoice_5)
  #   create(:transaction, result: 1, invoice: @invoice_6)

  #   @customer_4 = create(:customer)
  #   @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4)
  #   create(:transaction, result: 1, invoice: @invoice_7)
  #   create(:transaction, result: 1, invoice: @invoice_7)
  #   create(:transaction, result: 1, invoice: @invoice_7)
  #   create(:transaction, result: 1, invoice: @invoice_7)
  #   create(:transaction, result: 1, invoice: @invoice_7)

  #   @customer_3 = create(:customer)
  #   @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_3)
  #   create(:transaction, result: 0, invoice: @invoice_7)

  #   @customer_6 = create(:customer)
  #   @invoice_9 = create(:invoice, merchant: @merchant, customer: @customer_6)
  #   @invoice_10 = create(:invoice, merchant: @merchant, customer: @customer_6)
  #   create(:transaction, result: 1, invoice: @invoice_9)

  #   create_list(:item, 3, merchant: @merchant)

  #   5.times do
  #     create(:invoice_item, item: Item.first, invoice: Invoice.all.sample, status: 2)
  #   end

  #   5.times do
  #     create(:invoice_item, item: Item.second, invoice: Invoice.all.sample, status: 1)
  #   end

  #   5.times do
  #     create(:invoice_item, item: Item.third, invoice: Invoice.all.sample, status: 0)
  #   end
  end

  describe 'instance methods' do
    before :each do
      # Merchant.destroy_all
      # Customer.destroy_all
      # Transaction.destroy_all
      # Invoice.destroy_all
  
      #@merchant = create(:merchant)
  
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
      @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
      create(:transaction, result: 1, invoice: @invoice_1)
      create(:transaction, result: 1, invoice: @invoice_2)
  
      @customer_2 = create(:customer)
      @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
      @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_3)
      create(:transaction, result: 1, invoice: @invoice_4)
  
      @customer_5 = create(:customer)
      @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_5)
      @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_5)
      create(:transaction, result: 1, invoice: @invoice_5)
      create(:transaction, result: 1, invoice: @invoice_5)
      create(:transaction, result: 1, invoice: @invoice_6)
  
      @customer_4 = create(:customer)
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
      create(:transaction, result: 1, invoice: @invoice_7)
  
      @customer_3 = create(:customer)
      @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_3)
      create(:transaction, result: 0, invoice: @invoice_7)
  
      @customer_6 = create(:customer)
      @invoice_9 = create(:invoice, merchant: @merchant, customer: @customer_6)
      @invoice_10 = create(:invoice, merchant: @merchant, customer: @customer_6)
      create(:transaction, result: 1, invoice: @invoice_9)
  
      create_list(:item, 3, merchant: @merchant)
  
      5.times do
        create(:invoice_item, item: Item.first, invoice: Invoice.all.sample, status: 2)
      end
  
      5.times do
        create(:invoice_item, item: Item.second, invoice: Invoice.all.sample, status: 1)
      end
  
      5.times do
        create(:invoice_item, item: Item.third, invoice: Invoice.all.sample, status: 0)
      end
    end
    it '#top_5_customers' do
      expect(@merchant.customers.count).to eq(10)
      top = [@customer_4.first_name, @customer_2.first_name, @customer_5.first_name, @customer_1.first_name, @customer_6.first_name]
      actual = @merchant.top_5.map { | x | x[:first_name]}
      expect(actual).to eq(top)
    end

    it '#ready_to_ship' do
      expected = @merchant.ready_to_ship
      expect(expected.length).to eq(10)
    end
  end
  describe 'class methods' do
    before :each do
      @merchant1 = create(:merchant, status: 0, name: '1')
      @merchant2 = create(:merchant, status: 0, name: '2')
      @merchant3 = create(:merchant, status: 1, name: '3')
    end
    it '::enabled' do
      expect(Merchant.enabled).to eq([@merchant3])
    end
    it '::disabled' do
      expect(Merchant.disabled).to eq([@merchant, @merchant1, @merchant2])
    end
    it '::top_5_revenue' do
      merchant4 = create(:merchant, name: '4')
      merchant5 = create(:merchant, name: '5')
      merchant6 = create(:merchant, name: '6')
      merchant7 = create(:merchant, name: '7')
  
      customer1 = create(:customer)
  
      invoice1 = create(:invoice, customer: customer1, merchant: @merchant1)
      invoice2 = create(:invoice, customer: customer1, merchant: @merchant2)
      invoice3 = create(:invoice, customer: customer1, merchant: @merchant3)
      invoice4 = create(:invoice, customer: customer1, merchant: merchant4)
      invoice5 = create(:invoice, customer: customer1, merchant: merchant5)
      invoice6 = create(:invoice, customer: customer1, merchant: merchant6)
      invoice7 = create(:invoice, customer: customer1, merchant: merchant7)

      transaction1 = create(:transaction, invoice: invoice1, result: 1)
      transaction2 = create(:transaction, invoice: invoice2, result: 1)
      transaction3 = create(:transaction, invoice: invoice3, result: 1)
      transaction4 = create(:transaction, invoice: invoice4, result: 1)
      transaction5 = create(:transaction, invoice: invoice5, result: 1)
      transaction6 = create(:transaction, invoice: invoice6, result: 1)
      transaction7 = create(:transaction, invoice: invoice7, result: 0)

      item1 = create(:item, merchant: @merchant1)
      item2 = create(:item, merchant: @merchant2)
      item3 = create(:item, merchant: @merchant3)
      item4 = create(:item, merchant: merchant4)
      item5 = create(:item, merchant: merchant5)
      item6 = create(:item, merchant: merchant6)
      item7 = create(:item, merchant: merchant7)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 1, unit_price: 300) #300 rev
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 2, unit_price: 15) #30 rev
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 2, unit_price: 40) # 80 rev
      invoice_item4 = create(:invoice_item, item: item4, invoice: invoice4, quantity: 4, unit_price: 50) # 200 rev
      invoice_item5 = create(:invoice_item, item: item5, invoice: invoice5, quantity: 10, unit_price: 10) # 100 rev
      invoice_item6 = create(:invoice_item, item: item6, invoice: invoice6, quantity: 4, unit_price: 30) # 120 rev
      invoice_item7 = create(:invoice_item, item: item7, invoice: invoice7, quantity: 10, unit_price: 5) # 50 rev
      invoice_item8 = create(:invoice_item, item: item7, invoice: invoice7, quantity: 1, unit_price: 110) # 110 rev
      
      expect(Merchant.top_5_merchants).to eq([@merchant1, merchant4, merchant6, merchant5, @merchant3])
    end
  end
end
