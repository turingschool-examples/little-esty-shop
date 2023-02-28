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
      Merchant.destroy_all
      Customer.destroy_all
      Invoice.destroy_all
      Item.destroy_all
      Transaction.destroy_all
      InvoiceItem.destroy_all

      @merchant = Merchant.create(name: "Handmades")

        @cust1 = FactoryBot.create(:customer)
        @cust2 = FactoryBot.create(:customer)

        @inv1 = @cust1.invoices.create!(status: 1, created_at: Date.new(2023,2,28)) # today
        @trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans1_5 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv7 = @cust2.invoices.create!(status: 1, created_at: Date.new(2023,2,28)) # today
        @trans17 = @inv7.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        
        @inv4 = @cust2.invoices.create!(status: 1, created_at: Date.new(2023,2,26)) # 2 days ago
        @trans7 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans8 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans9 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans10 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @inv5 = @cust2.invoices.create!(status: 1, created_at: Date.new(2023,2,25)) # 3 days ago
        @trans11 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans12 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans13 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans14 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans15 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @inv6 = @cust2.invoices.create!(status: 1, created_at: Date.new(2023,2,23)) # 5 days ago
        @trans16 = @inv6.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @inv3 = @cust1.invoices.create!(status: 1, created_at: Date.new(2023,2,22)) # 6 days ago
        @trans4 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans5 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans6 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @inv2 = @cust1.invoices.create!(status: 1, created_at: Date.new(2023,2,21)) # 7 days ago
        @trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans3 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @inv8 = @cust1.invoices.create!(status: 1, created_at: Date.new(2023,2,21)) # 7 days ago
        @trans17 = @inv8.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans18 = @inv8.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @bowl = @merchant.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
        @knife = @merchant.items.create!(name: "Knife", description: "it's a knife", unit_price: 300) 
        @spoon = @merchant.items.create!(name: "Spoon", description: "it's a spoon", unit_price: 275) 
        @plate = @merchant.items.create!(name: "Plate", description: "it's a plate", unit_price: 250) 
        @fork = @merchant.items.create!(name: "Fork", description: "it's a fork", unit_price: 100) 
        @pan = @merchant.items.create!(name: "Pan", description: "it's a pan", unit_price: 250) 
        
        @invoice_item = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, quantity: 10, unit_price: 350, status: 1)
                        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv7.id, quantity: 40, unit_price: 350, status: 1)
                        #inv1 and inv7 on the same day - total quantity 50 - newest date
                        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id, quantity: 50, unit_price: 350, status: 1)
                        # inv2 - 50 items (tied) on older date
                        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv3.id, quantity: 10, unit_price: 350, status: 1)


        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv3.id, quantity: 9, unit_price: 300, status: 1)
        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv4.id, quantity: 2, unit_price: 300, status: 1)
        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, quantity: 90, unit_price: 300, status: 1)

        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv2.id, quantity: 10, unit_price: 201, status: 1)
        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv4.id, quantity: 20, unit_price: 201, status: 1)
        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv8.id, quantity: 10, unit_price: 201, status: 1)
        #inv 4 total quantity 20 - earlier date
        #inv 2 and inv 8 on the same day - total quantity 20 - older date

        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv1.id, quantity: 8, unit_price: 2500, status: 1)
        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv4.id, quantity: 3, unit_price: 2500, status: 1)
        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv7.id, quantity: 20, unit_price: 2500, status: 1)


        InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv5.id, quantity: 1, unit_price: 14, status: 1)
        InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv4.id, quantity: 2, unit_price: 14, status: 1)
        
        InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv2.id, quantity: 2, unit_price: 15, status: 1)
        InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv6.id, quantity: 6, unit_price: 15, status: 1)

    end

    it 'shows the day of most revenue for item' do
      expect(@bowl.item_best_day.created_at).to eq('2023-02-28 00:00:00 UTC')
      expect(@knife.item_best_day.created_at).to eq('2023-02-28 00:00:00 UTC')
      expect(@plate.item_best_day.created_at).to eq('2023-02-26 00:00:00 UTC')
      expect(@spoon.item_best_day.created_at).to eq('2023-02-28 00:00:00 UTC')
      expect(@fork.item_best_day.created_at).to eq('2023-02-26 00:00:00 UTC')
      expect(@pan.item_best_day.created_at).to eq('2023-02-23 00:00:00 UTC')
    end
  end
end
