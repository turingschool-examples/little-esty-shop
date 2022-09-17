require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")

    @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id)
    @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id)

    @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
    @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
    @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
    @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
    @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
    @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")

    @invoice_1 = Invoice.create!(status: :completed, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: :completed, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: :completed, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: :completed, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: :completed, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: "in progress", customer_id: @customer_6.id)

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
    @transaction_22 = Transaction.create!(result: :failed, invoice_id: @invoice_6.id, credit_card_number: "654498711")

    @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_6.id)
  end

  describe 'US1' do
    describe 'admin index page' do
      it 'has an admin dashboard header' do
        visit "/admin"
        expect(page).to have_content("Admin Dashboard")
        expect(page).to_not have_content("Merchant Dashboard")
      end
    end
  end

  describe 'US2' do
    describe 'admin index page' do
      it 'has a link to the admin merchants index' do
        visit "/admin"

        click_link "Admin Merchants Index"

        expect(current_path).to eq("/admin/merchants")
      end

      it 'has a link to the admin invoices index' do
        visit "/admin"

        click_link "Admin Invoices Index"

        expect(current_path).to eq("/admin/invoices")
      end
    end
  end

  describe 'US3' do
    describe 'When I visit the admin dashboard' do
      it "I see the names of the top 5 customers who have conducted the largest number of successful transactions" do

        visit "/admin"

        expect(page).to have_content("Top Customers")
        expect("Meat Loaf").to appear_before("Shannon Dougherty")
        expect("Shannon Dougherty").to appear_before("Puff Daddy")
        expect("Puff Daddy").to appear_before("Walter Wheat")
        expect("Walter Wheat").to appear_before("David Dowie")
      end

      it 'next to each customer name I see the number of successful transactions they have
      conducted' do

        visit "/admin"

        within("#customer-#{@customer_1.id}") do
          expect(page).to have_content("6")
        end
      end
    end
    describe 'US4' do
      describe 'when I visit the Incomplete Invoices on Admin Dashboard' do
        before :each do
          @item_7 = Item.create!(name: "Garlic Bread", description: "Garlicky, goodness", unit_price: 566, merchant_id: @merchant_1.id)
          @invoice_7 = Invoice.create!(status: 0, customer_id: @customer_1.id)
          @invoice_item_7 = InvoiceItem.create!(quantity: 4, unit_price: 434, status: 0, item_id: @item_7.id, invoice_id: @invoice_7.id)
        end
        it 'displays a section for Incomplete Invoices and links the id' do
          visit "/admin"

          within("#incompleteInvoices") do
            expect(page).to have_content("Incomplete Invoices")
            expect(page).to have_content("Invoice ID number: #{@invoice_7.id}")
            expect(page).to_not have_content("Invoice ID number: #{@invoice_6.id}")
          end
        end
        it 'links the incomplete id to the admin invoice show page' do
          visit "/admin"
          click_link("Invoice ID number: #{@invoice_7.id}")
          expect(current_path).to eq("/admin/invoices/#{@invoice_7.id}")
        end
      end
    end
  end
end
