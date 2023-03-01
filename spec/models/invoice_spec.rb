require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should define_enum_for(:status).with_values(["in progress", "completed", "cancelled"]) }
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

      expect(@item[1].invoices.most_transactions_date).to eq([@invoice2])
      end 

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
        @transactions5 = FactoryBot.create(:transaction, invoice: @invoice3, result: 0)

        @invoiceitems1 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item[1], unit_price: 1, quantity: 1)
        @invoiceitems2 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item[1], unit_price: 1, quantity: 1)
        @invoiceitems3 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item[1], unit_price: 1, quantity: 1)
        
        expect(@item[1].invoices.most_transactions_date).to eq([@invoice3]) 
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

    describe '#total_revenue' do
      it 'multiplies the sum of the unit price and quantity' do
        expect(@invoice_1.total_revenue).to eq(67)
      end
    end

    describe '#format_date' do
      it 'returns the date of the invoice in yyyy/mm/dd format' do
        @invoice_1.created_at = "Mon, 27 Feb 2023 22:51:42 UTC +00:00"
        expect(@invoice_1.format_date).to eq("2023-02-27")
      end
    end
  end

  describe "class method" do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Mel's Travels")
      @merchant2 = Merchant.create!(name: "Hady's Beach Shack")

      @item1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 1200, merchant: @merchant1)
      @item2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 1150, merchant: @merchant1)
      @item3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 1325, merchant: @merchant1)

      @item4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 1425, merchant: @merchant2)
      @item5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 1500, merchant: @merchant2)

      @deniz = Customer.create!(first_name: "Deniz", last_name: "Ocean")
      @invoice3 = Invoice.create!(customer: @deniz, created_at: 1.days.ago, updated_at: 1.days.ago, status: 0) 
      @invoice4 = Invoice.create!(customer: @deniz, created_at: 1.days.ago, updated_at: 1.days.ago, status: 0) 
      @invoice5 = Invoice.create!(customer: @deniz, created_at: 4.days.ago, updated_at: 4.days.ago, status: 0) 
      @ii1 = InvoiceItem.create!(item: @item1, invoice: @invoice3, quantity: 1, unit_price: 1950, status: 0) 
      @ii2 = InvoiceItem.create!(item: @item2, invoice: @invoice4, quantity: 1, unit_price: 2850, status: 2) 
      @ii3 = InvoiceItem.create!(item: @item3, invoice: @invoice5, quantity: 1, unit_price: 1650, status: 1) 
      @invoice3.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) 
      @invoice4.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) 
      @invoice5.transactions.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: "07/29", result: 0) 

      @emre = Customer.create!(first_name: "Emre", last_name: "Bond")
      @invoice6  = Invoice.create!(customer: @emre, created_at: 3.days.ago, updated_at: 3.days.ago, status: 0) 
      @ii4 = InvoiceItem.create!(item: @item4, invoice: @invoice6, quantity: 1, unit_price: 9950, status: 1) 
      @ii5 = InvoiceItem.create!(item: @item5, invoice: @invoice6, quantity: 1, unit_price: 1000, status: 2)
      @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) 

      @serap = Customer.create!(first_name: "Serap", last_name: "Yilmaz")
      @invoice7  = Invoice.create!(customer: @serap, created_at: 2.days.ago, updated_at: 2.days.ago, status: 0) 
      @ii6 = InvoiceItem.create!(item: @item4, invoice: @invoice7, quantity: 1, unit_price: 9950, status: 1) 
      @ii7 = InvoiceItem.create!(item: @item5, invoice: @invoice7, quantity: 1, unit_price: 1000, status: 1) 
      @invoice6.transactions.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: "08/29", result: 0) 
    end

    describe "#incomplete_invoices" do
      let(:unshipped_invoices) { Invoice.incomplete_invoices }

      it "returns an array of unshipped invoices" do
        expect(unshipped_invoices.first.invoice_items.first.status).to eq("packaged")
        expect(unshipped_invoices.second.invoice_items.first.status).to eq("packaged")
        expect(unshipped_invoices.last.invoice_items.first.status).to eq("pending")
      end

      it "ordered from oldest to newest" do
        expect(unshipped_invoices.to_a).to eq([@invoice5, @invoice6, @invoice7, @invoice3])
      end
    end
  end
end
