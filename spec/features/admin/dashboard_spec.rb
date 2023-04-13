require 'rails_helper'

RSpec.describe "Admin Dashboard" do
   before :each do
      test_data
      @invoice_11 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_12 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_13 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_14 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_15 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_16 = Invoice.create!(status: "completed", customer_id: @customer_2.id)
      @invoice_17 = Invoice.create!(status: "completed", customer_id: @customer_2.id)
      @invoice_18 = Invoice.create!(status: "completed", customer_id: @customer_2.id)
      @invoice_19 = Invoice.create!(status: "completed", customer_id: @customer_2.id)
      @invoice_20 = Invoice.create!(status: "completed", customer_id: @customer_3.id)
      @invoice_21 = Invoice.create!(status: "completed", customer_id: @customer_3.id)
      @invoice_22 = Invoice.create!(status: "completed", customer_id: @customer_3.id)
      @invoice_23 = Invoice.create!(status: "completed", customer_id: @customer_4.id)
      @invoice_24 = Invoice.create!(status: "completed", customer_id: @customer_4.id)
      @invoice_25 = Invoice.create!(status: "completed", customer_id: @customer_5.id)
      @invoice_26 = Invoice.create!(status: "completed", customer_id: @customer_5.id)
      @invoice_27 = Invoice.create!(status: "completed", customer_id: @customer_4.id)
      @invoice_28 = Invoice.create!(status: "completed", customer_id: @customer_3.id)
  
      @invoice_item_21 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_22 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_12.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_23 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_13.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_24 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_14.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_25 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_15.id, quantity: 1, unit_price: 100, status: "shipped")
      @invoice_item_26 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_16.id, quantity: 1, unit_price: 1500, status: "shipped")
      @invoice_item_27 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_17.id, quantity: 1, unit_price: 1500, status: "shipped")
      @invoice_item_28 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_18.id, quantity: 1, unit_price: 1500, status: "shipped")
      @invoice_item_29 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_19.id, quantity: 1, unit_price: 1500, status: "shipped")
      @invoice_item_30 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_20.id, quantity: 1, unit_price: 50000, status: "shipped")
      @invoice_item_31 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_21.id, quantity: 1, unit_price: 50000, status: "shipped")
      @invoice_item_32 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_22.id, quantity: 1, unit_price: 50000, status: "shipped")
      @invoice_item_33 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_23.id, quantity: 1, unit_price: 20000, status: "shipped")
      @invoice_item_34 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_24.id, quantity: 1, unit_price: 20000, status: "shipped")
      @invoice_item_35 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_25.id, quantity: 1, unit_price: 25000, status: "shipped")
      @invoice_item_36 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_26.id, quantity: 1, unit_price: 25000, status: "shipped")
      @invoice_item_37 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_27.id, quantity: 1, unit_price: 20000, status: "shipped")
      @invoice_item_38 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_28.id, quantity: 1, unit_price: 50000, status: "shipped")
  
      @transaction_11 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_11)
      @transaction_12 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_12)
      @transaction_13 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_13)
      @transaction_14 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_14)
      @transaction_15 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_15)
      @transaction_16 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_16)
      @transaction_17 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_17)
      @transaction_18 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_18)
      @transaction_19 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_19)
      @transaction_20 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_20)
      @transaction_21 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_21)
      @transaction_22 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_22)
      @transaction_23 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_23)
      @transaction_24 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_24)
      @transaction_25 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_25)
      @transaction_26 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_26)
      @transaction_27 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_27)
      @transaction_28 = Transaction.create!(credit_card_number: 1234567890123456, credit_card_expiration_date: "2024-01-01", result: 1, invoice: @invoice_28)
    end

   it 'has a header indicating that it is the admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
   end

   it 'has a link to the admin merchants index' do
      visit '/admin'

      expect(page).to have_link("Merchants")
   end

    it 'has a link to the admin invoices index' do
      visit '/admin'

      expect(page).to have_link("Invoices")
   end

   it 'lists the top 5 customers by successful transactions' do
      visit '/admin'

      expect(page).to have_content("Top 5 Customers")
      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}'s Transactions: 6")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}'s Transactions: 5")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}'s Transactions: 4")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}'s Transactions: 3")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}'s Transactions: 2")
   end
  end