require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe 'Methods for Merchant Dashboard' do
    before(:each) do
      @merchant = Merchant.create!(name: "Parker")
      @merchant2 = Merchant.create!(name: "Joel")

      @item = @merchant.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
      @item2 = @merchant.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
      @item3 = @merchant.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 800)
      @item4 = @merchant.items.create!(name: "smallish Thing", description: "Its a thing that is smallish.", unit_price: 800)
      @item5 = @merchant.items.create!(name: "cute Thing", description: "Its a thing that is cute.", unit_price: 800)
      # edge case
      @item6 = @merchant2.items.create!(name: "Thing that shouldn't be there", description: "Its the thing that shouldn't be there.", unit_price: 10)

      @customer_1 = Customer.create!(first_name: "Fred", last_name: "Rogers")
      @customer_2 = Customer.create!(first_name: "Big", last_name: "Bird")
      @customer_3 = Customer.create!(first_name: "Oscar", last_name: "Grouch")
      @customer_4 = Customer.create!(first_name: "Miss", last_name: "Piggy")
      @customer_5 = Customer.create!(first_name: "Kermit", last_name: "Frog")
      @customer_6 = Customer.create!(first_name: "Fred", last_name: "Flinstone")

      @invoice_1 = @customer_1.invoices.create!(status: "in progress")
      @transaction_1  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_2  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_3  = @invoice_1.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

      @invoice_2 = @customer_2.invoices.create!(status: "in progress")
      @transaction_4  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_5  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_6  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_7  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_8  = @invoice_2.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

      @invoice_3 = @customer_3.invoices.create!(status: "in progress")
      @transaction_9  = @invoice_3.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

      @invoice_4 = @customer_4.invoices.create!(status: "in progress")
      @transaction_10  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_11  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_12  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_13  = @invoice_4.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")

      @invoice_5 = @customer_5.invoices.create!(status: "in progress")
      @transaction_14  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_15  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "success")
      @transaction_16  = @invoice_5.transactions.create!(credit_card_number: "1234 2345 3456 4567", credit_card_expiration_date: Date.new, result: "failed")

      @invoice_item_1 = InvoiceItem.create!(invoice: @invoice_1, item: @item, quantity: 20, unit_price: 400, status: "pending")
      @invoice_item_2 = InvoiceItem.create!(invoice: @invoice_2, item: @item2, quantity: 20, unit_price: 400, status: "pending")
      @invoice_item_3 = InvoiceItem.create!(invoice: @invoice_3, item: @item3, quantity: 20, unit_price: 400, status: "packaged")
      @invoice_item_4 = InvoiceItem.create!(invoice: @invoice_4, item: @item4, quantity: 20, unit_price: 400, status: "packaged")
      @invoice_item_5 = InvoiceItem.create!(invoice: @invoice_5, item: @item5, quantity: 20, unit_price: 400, status: "packaged")
    end

    describe '#top_customers' do
      it 'returns the top 5 customers for a merchant' do
        customers = [@customer_2, @customer_4, @customer_1, @customer_5, @customer_3]
        expect(@merchant.top_customers).to eq(customers)
      end
    end

    describe '#ready_items' do
      it 'returns the items which have not yet shipped' do
        items = [@item3, @item4, @item5]
        expect(@merchant.ready_items).to eq(items)
      end
    end
  end

  describe "Methods for Merchant Items Index Page" do
    before (:each) do
      @merch_1 = Merchant.create!(name: "Cat Stuff")
      @merch_2 = Merchant.create!(name: "Dog Stuff")

      @cust1 = FactoryBot.create(:customer)
      @cust2 = FactoryBot.create(:customer)
      @cust3 = FactoryBot.create(:customer)

      @inv1 = @cust1.invoices.create!(status: 1)
      @tran1 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)
      @tran2 = FactoryBot.create(:transaction, invoice: @inv1,  result: 1)

      @inv2 = @cust1.invoices.create!(status: 1)
      @tran3 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)
      @tran4 = FactoryBot.create(:transaction, invoice: @inv2,  result: 1)

      @inv3 = @cust2.invoices.create!(status: 1)
      @tran7 = FactoryBot.create(:transaction, invoice: @inv3,  result: 1)

      @inv4 = @cust2.invoices.create!(status: 1)
      @tran8 = FactoryBot.create(:transaction, invoice: @inv4,  result: 1)

      @inv5 = @cust3.invoices.create!(status: 1)
      @tran9 = FactoryBot.create(:transaction, invoice: @inv5,  result: 1)

      #edge cases below; needs result AND status BOTH must == 1
      #need to create ii with these so they are edge cases
      @inv6 = @cust3.invoices.create!(status: 0)
      @tran10 = FactoryBot.create(:transaction, invoice: @inv6,  result: 1)

      @inv7 = @cust3.invoices.create!(status: 1)
      @tran11 = FactoryBot.create(:transaction, invoice: @inv7,  result: 0)

      @inv8 = @cust3.invoices.create!(status: 0)
      @tran12 = FactoryBot.create(:transaction, invoice: @inv8,  result: 0)

      @item1 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 100)
      @item2 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 200)
      @item3 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 300)
      @item4 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 400)
      @item5 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 500)
      @item6 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 600)
      @item7 = FactoryBot.create(:item, merchant: @merch_1, unit_price: 700)
      @item8 = FactoryBot.create(:item, merchant: @merch_2, unit_price: 10000)

      @ii_1 = InvoiceItem.create!(invoice: @inv1, item: @item7, quantity: 20, unit_price: 700, status: "pending")
      #14000
      @ii_2 = InvoiceItem.create!(invoice: @inv1, item: @item5, quantity: 10, unit_price: 500, status: "pending")
      #5000
      @ii_3 = InvoiceItem.create!(invoice: @inv2, item: @item7, quantity: 20, unit_price: 700, status: "pending")
      #14000
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item5, quantity: 10, unit_price: 500, status: "pending")
      #5000
      @ii_4 = InvoiceItem.create!(invoice: @inv2, item: @item1, quantity: 30, unit_price: 100, status: "pending")
      #3000
      @ii_5 = InvoiceItem.create!(invoice: @inv3, item: @item4, quantity: 3, unit_price: 400, status: "pending")
      #1200
      @ii_6 = InvoiceItem.create!(invoice: @inv3, item: @item1, quantity: 30, unit_price: 100, status: "pending")
      #3000
      @ii_7 = InvoiceItem.create!(invoice: @inv3, item: @item2, quantity: 5, unit_price: 200, status: "pending")
      #1000 - Item2 won't be in top 5
      @ii_8 = InvoiceItem.create!(invoice: @inv4, item: @item3, quantity: 5, unit_price: 300, status: "pending")
      #1500
      @ii_9 = InvoiceItem.create!(invoice: @inv5, item: @item3, quantity: 5, unit_price: 300, status: "pending")
      #1500
      @ii_10 = InvoiceItem.create!(invoice: @inv5, item: @item6, quantity: 1, unit_price: 600, status: "pending")
      #600 - Item6 won't be in top 5

      #edge cases!
      @ii_11 = InvoiceItem.create!(invoice: @inv6, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_12 = InvoiceItem.create!(invoice: @inv7, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_13 = InvoiceItem.create!(invoice: @inv8, item: @item6, quantity: 2000, unit_price: 600, status: "pending")
      @ii_14 = InvoiceItem.create!(invoice: @inv8, item: @item8, quantity: 2000, unit_price: 10000, status: "pending")

    end

    describe '#top_items' do
      it 'returns the top 5 items for a merchant ranked by total revenue generated' do
        top_5_items = [@item7, @item5, @item1, @item3, @item4]

        expect(@merch_1.top_items).to eq(top_5_items)
      end
    end
  end
end
