require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should define_enum_for(:status).with_values(["in progress", "completed", "cancelled"])}
  end

    describe "class methods" do
      it "when provided with an item belonging to a specific merchant, can calculate the invoice date on which the item has the most successful transactions" do 
      
      @merchant= FactoryBot.create(:merchant)
      @item = FactoryBot.create_list(:item, 2, merchant: @merchant)
      @customer = FactoryBot.create(:customer)

      @invoice1= FactoryBot.create(:invoice, status: 0, customer: @customer, created_at: Time.new(2023, 1, 1, 0, 0, 0))
      @invoice2= FactoryBot.create(:invoice, status: 0, customer: @customer, created_at: Time.new(2015, 1, 1, 0, 0, 0))
      @invoice3= FactoryBot.create(:invoice, status: 0, customer: @customer, created_at: Time.new(2017, 1, 1, 0, 0, 0))

      @transactions1 = FactoryBot.create(:transaction, invoice: @invoice1, result: 0)
      @transactions2 = FactoryBot.create(:transaction, invoice: @invoice2, result: 0)
      @transactions3 = FactoryBot.create(:transaction, invoice: @invoice3, result: 0)
      @transactions4 = FactoryBot.create(:transaction, invoice: @invoice2, result: 0)
      @transactions20 = FactoryBot.create(:transaction, invoice: @invoice3, result: 1)
      @transactions21 = FactoryBot.create(:transaction, invoice: @invoice3, result: 1)
      @transactions22 = FactoryBot.create(:transaction, invoice: @invoice3, result: 1)
      @transactions23 = FactoryBot.create(:transaction, invoice: @invoice3, result: 1)
      @transactions24 = FactoryBot.create(:transaction, invoice: @invoice3, result: 1)

      @invoiceitems1 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item[1], unit_price: 1, quantity: 1)
      @invoiceitems2 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item[1], unit_price: 1, quantity: 1)
      @invoiceitems3 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item[1], unit_price: 1, quantity: 1)

      
      expect(Invoice.most_transactions_date(@item[1].id)).to eq([@invoice2])

      end 
    end

    describe 'instance methods' do
      before(:each) do
        @merchant_1 = Merchant.create!(name: "Mel's Travels")
        @merchant_2 = Merchant.create!(name: "Hady's Beach Shack")
        @merchant_3 = Merchant.create!(name: "Huy's Cheese")
    
        @item_1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 12, merchant: @merchant_1)
        @item_2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 11, merchant: @merchant_1)
        @item_3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 13, merchant: @merchant_1)
        @item_4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 14, merchant: @merchant_2)
        @item_5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 15, merchant: @merchant_2)
        @item_6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 33, merchant: @merchant_2)
        @item_7 = Item.create!(name: "American", description: "gud cheese", unit_price: 34, merchant: @merchant_3)
        @item_8 = Item.create!(name: "Swiss", description: "holes in cheese", unit_price: 92, merchant: @merchant_3)
        @item_9 = Item.create!(name: "Cheddar", description: "SHARP!", unit_price: 1123, merchant: @merchant_3)
        @item_10 = Item.create!(name: "Imaginary", description: "it is whatever you think it is", unit_price: 442, merchant: @merchant_3)
        
        @customer_1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
        @customer_2 = Customer.create!(first_name: "Dave", last_name: "Davinson")
        
        @invoice_1 = Invoice.create!(customer: @customer_1)
        @invoice_2 = Invoice.create!(customer: @customer_2, status: 0)
    
    
        InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
        InvoiceItem.create!(item: @item_2, invoice: @invoice_1, quantity: 5, unit_price: @item_2.unit_price)
    
      end

      describe '::total_revenue' do
        it 'multiplies the sum of the unit price and quantity' do
          expect(@invoice_1.total_revenue).to eq(67)
        end
      end


    end
end
