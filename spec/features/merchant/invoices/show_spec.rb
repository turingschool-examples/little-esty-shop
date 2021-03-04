require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and pop')

    @item_1 = @merchant_1.items.create!(name: 'worker pain', unit_price: 1, description: "Stuff 1")
    @item_2 = @merchant_1.items.create!(name: 'union busting', unit_price: 3, description: "Stuff 2")
    @item_3 = @merchant_1.items.create!(name: 'climate desctruction', unit_price: 2, description: "Stuff 3")
    @item_4 = @merchant_1.items.create!(name: 'something you can only find here', unit_price: 2, description: "Stuff 4")
    @item_5 = @merchant_2.items.create!(name: 'Garfield things', unit_price: 20, description: "Stuff 5")

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer_3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer_4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer_5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer_6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "completed", created_at: "1991-03-23 21:40:46")
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "completed", created_at: "1992-01-28 21:40:46")
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: "completed", created_at: "1993-01-28 21:40:46")
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: "completed", created_at: "1994-01-28 21:40:46")
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: "completed", created_at: "1995-01-28 21:40:46")
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: "completed", created_at: "2021-01-28 21:40:46")
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: "completed", created_at: "2021-01-28 21:40:46")

    @invoice_items_1 = InvoiceItem.create!(item: @item_2, invoice: @invoice_1, status: "packaged", quantity: 10, unit_price: 5)
    @invoice_items_2 = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, status: "shipped")
    @invoice_items_3 = InvoiceItem.create!(item: @item_1, invoice: @invoice_3, status: "packaged")
    @invoice_items_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_4, status: "packaged")
    @invoice_items_5 = InvoiceItem.create!(item: @item_1, invoice: @invoice_5, status: "shipped")
    @invoice_items_6 = InvoiceItem.create!(item: @item_1, invoice: @invoice_6, status: "packaged")
    @invoice_items_7 = InvoiceItem.create!(item: @item_5, invoice: @invoice_7, status: "packaged")

    @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
    @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
    @transaction_03 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
    @transaction_04 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_05 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_06 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
    @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
    @transaction_08 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_09 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_10 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_11 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_12 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_13 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_14 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_15 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_16 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_17 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_18 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_19 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_20 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_21 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    @transaction_22 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
  end

  describe "When I visit my invoices show page" do
    it "show the id, status, customer name and a formatted created at date for a given invoice " do

      visit merchant_invoice_path(@merchant_1.id, @invoice_6.id)

      expect(page).to have_content(@invoice_6.id)
      expect(page).to have_content(@invoice_6.status)
      expect(page).to have_content(@invoice_6.format_time)
      expect(page).to have_content(@customer_6.name)
    end

    it "show the item quantity, price sold for, status for all items on the invoice" do

      visit merchant_invoice_path(@merchant_1.id, @invoice_6.id)

      expect(page).to have_content(@item_1.name)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_items_6.quantity)
      expect(page).to have_content(@invoice_items_6.unit_price)
      expect(page).to have_content(@invoice_items_6.status)
    end

    it "shows the total revenue for this invoice" do

      visit merchant_invoice_path(@merchant_1.id, @invoice_1.id)

      expect(page).to have_content('$50.00')
    end
  end
end
