require 'rails_helper'

RSpec.describe Item, type: :model do

    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:unit_price) }
    end

    describe 'relationships' do
        it { should belong_to(:merchant) }
        it { should have_many(:invoice_items) }
        it { should have_many(:invoices).through(:invoice_items) }
        it { should have_many(:transactions).through(:invoices) }
        it { should have_many(:customers).through(:invoices) }
    end

    
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
        @merchant_3 = Merchant.create!(name: "Sheena Yeaston")
        @merchant_4 = Merchant.create!(name: "Taylor Sift")
        @merchant_5 = Merchant.create!(name: "Rye-n Rye-nolds")
        @merchant_6 = Merchant.create!(name: "Bread Paisley")
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_2.id)
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_3.id)
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_4.id)
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_5.id)
        @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_6.id)
        @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
        @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_2.id)
        @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_3.id)
        @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_4.id)
        @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_5.id)
        @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)
        @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_3.id)
        @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_4.id)
        @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id)
        @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_2.id)
        @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_3.id)
        @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id)

        @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
        @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
        @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
        @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
        @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
        @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")

        @invoice_1 = Invoice.create!(status: :completed, customer_id: @customer_1.id, created_at: "Fri, 30 Aug 2021 12:28:44 UTC +00:00")
        @invoice_2 = Invoice.create!(status: :completed, customer_id: @customer_2.id, created_at: "Fri, 30 Sep 2021 13:28:44 UTC +00:00")
        @invoice_3 = Invoice.create!(status: :completed, customer_id: @customer_3.id, created_at: "Fri, 30 Oct 2021 14:28:44 UTC +00:00")
        @invoice_4 = Invoice.create!(status: :completed, customer_id: @customer_4.id, created_at: "Fri, 30 Nov 2021 15:28:44 UTC +00:00")
        @invoice_5 = Invoice.create!(status: :completed, customer_id: @customer_5.id, created_at: "Fri, 30 Dec 2021 16:28:44 UTC +00:00")
        @invoice_6 = Invoice.create!(status: :completed, customer_id: @customer_6.id, created_at: "Fri, 30 Jun 2021 17:28:44 UTC +00:00")

        @transaction_1 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
        @transaction_2 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
        @transaction_3 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
        @transaction_4 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
        @transaction_5 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")
        @transaction_6 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")

        @transaction_7 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
        @transaction_8 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
        @transaction_9 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
        @transaction_10 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")
        @transaction_11 = Transaction.create!(result: :success, invoice_id: @invoice_2.id, credit_card_number: "355646888")

        @transaction_12 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
        @transaction_13 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
        @transaction_14 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")
        @transaction_15 = Transaction.create!(result: :success, invoice_id: @invoice_3.id, credit_card_number: "888889999")

        @transaction_16 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
        @transaction_17 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")
        @transaction_18 = Transaction.create!(result: :success, invoice_id: @invoice_4.id, credit_card_number: "123456789")

        @transaction_19 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")
        @transaction_20 = Transaction.create!(result: :success, invoice_id: @invoice_5.id, credit_card_number: "987654321")

        @transaction_21 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")
        @transaction_22 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")

        @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
        @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
        @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
        @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
        @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_5.id)
        @invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_6.id)
    end

    describe 'class methods' do
        it '#top_five_items' do
          expect(Item.top_five_items.first).to eq(@item_1)
          expect(Item.top_five_items[1]).to eq(@item_2)
          expect(Item.top_five_items[2]).to eq(@item_3)
          expect(Item.top_five_items[3]).to eq(@item_4)
          expect(Item.top_five_items[4]).to eq(@item_5)
        end
    end

    describe 'instance methods' do
        it '#best_day' do
            expect(@item_1.best_day).to eq("2021-08-30 12:28:44.000000000 +0000")
        end
    end
end