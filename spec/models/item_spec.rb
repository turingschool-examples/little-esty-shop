require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'Instance Methods' do
    before do
      @merchant = Merchant.create(name: "Handmades")

        @cust1 = FactoryBot.create(:customer)
        @cust2 = FactoryBot.create(:customer)

        @inv1 = @cust1.invoices.create!(status: 1, created_at: Time.now - 1.day)
        @trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans1_5 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv2 = @cust1.invoices.create!(status: 1, created_at: Time.now - 7.day)
        @trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans3 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv3 = @cust1.invoices.create!(status: 1, created_at: Time.now - 6.day)
        @trans4 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans5 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans6 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv4 = @cust2.invoices.create!(status: 1, created_at: Time.now - 2.day)
        @trans7 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans8 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans9 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans10 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv5 = @cust2.invoices.create!(status: 1, created_at: Time.now - 3.day)
        @trans11 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans12 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans13 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans14 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans15 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv6 = @cust2.invoices.create!(status: 1, created_at: Time.now - 5.day)
        @trans16 = @inv6.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @bowl = @merchant.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
        @knife = @merchant.items.create!(name: "Knife", description: "it's a knife", unit_price: 300) 
        @spoon = @merchant.items.create!(name: "Spoon", description: "it's a spoon", unit_price: 275) 
        @plate = @merchant.items.create!(name: "Plate", description: "it's a plate", unit_price: 250) 
        @fork = @merchant.items.create!(name: "Fork", description: "it's a fork", unit_price: 100) 
        @pan = @merchant.items.create!(name: "Pan", description: "it's a pan", unit_price: 250) 
          
        @invoice_item = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, quantity: 10, unit_price: 350, status: 1)
        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id, quantity: 5, unit_price: 350, status: 1)
        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv3.id, quantity: 10, unit_price: 350, status: 1)

        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv3.id, quantity: 9, unit_price: 300, status: 1)
        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv4.id, quantity: 2, unit_price: 300, status: 1)
        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, quantity: 9, unit_price: 300, status: 1)

        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv1.id, quantity: 10, unit_price: 201, status: 1)
        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv4.id, quantity: 12, unit_price: 201, status: 1)
        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv5.id, quantity: 12, unit_price: 201, status: 1)

        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv1.id, quantity: 8, unit_price: 2500, status: 1)
        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv4.id, quantity: 3, unit_price: 2500, status: 1)

        InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv5.id, quantity: 1, unit_price: 14, status: 1)
        InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv4.id, quantity: 2, unit_price: 14, status: 1)
        
        InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv2.id, quantity: 2, unit_price: 15, status: 1)
        InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv6.id, quantity: 6, unit_price: 15, status: 1)

    end

    it 'shows the day of most revenue for item' do
      expect(@bowl.item_best_day).to eq(@inv1.created_at)
      expect(@knife.item_best_day).to eq(@inv1.created_at)
      expect(@plate.item_best_day).to eq(@inv4.created_at)
      expect(@spoon.item_best_day).to eq(@inv1.created_at)
      expect(@fork.item_best_day).to eq(@inv4.created_at)
      expect(@pan.item_best_day).to eq(@inv6.created_at)
    end
  end
end
