require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")

    @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id )
    @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id )
    @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id )
    @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id )
    @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id )

    @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
    @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
    @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
    @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
    @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
    @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")

    @invoice_1 = Invoice.create!(status: 2, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 2, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 2, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 2, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_6.id)

    @transaction_1 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")
    @transaction_2 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")
    @transaction_3 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")
    @transaction_4 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")
    @transaction_5 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")
    @transaction_6 = Transaction.create!(result: 0, invoice_id: @invoice_1.id, credit_card_number: "255448968")

    @transaction_7 = Transaction.create!(result: 0, invoice_id: @invoice_2.id, credit_card_number: "355646888")
    @transaction_8 = Transaction.create!(result: 0, invoice_id: @invoice_2.id, credit_card_number: "355646888")
    @transaction_9 = Transaction.create!(result: 0, invoice_id: @invoice_2.id, credit_card_number: "355646888")
    @transaction_10 = Transaction.create!(result: 0, invoice_id: @invoice_2.id, credit_card_number: "355646888")
    @transaction_11 = Transaction.create!(result: 0, invoice_id: @invoice_2.id, credit_card_number: "355646888")

    @transaction_12 = Transaction.create!(result: 0, invoice_id: @invoice_3.id, credit_card_number: "888889999")
    @transaction_13 = Transaction.create!(result: 0, invoice_id: @invoice_3.id, credit_card_number: "888889999")
    @transaction_14 = Transaction.create!(result: 0, invoice_id: @invoice_3.id, credit_card_number: "888889999")
    @transaction_15 = Transaction.create!(result: 0, invoice_id: @invoice_3.id, credit_card_number: "888889999")

    @transaction_16 = Transaction.create!(result: 0, invoice_id: @invoice_4.id, credit_card_number: "123456789")
    @transaction_17 = Transaction.create!(result: 0, invoice_id: @invoice_4.id, credit_card_number: "123456789")
    @transaction_18 = Transaction.create!(result: 0, invoice_id: @invoice_4.id, credit_card_number: "123456789")

    @transaction_19 = Transaction.create!(result: 0, invoice_id: @invoice_5.id, credit_card_number: "987654321")
    @transaction_20 = Transaction.create!(result: 0, invoice_id: @invoice_5.id, credit_card_number: "987654321")

    @transaction_21 = Transaction.create!(result: :success, invoice_id: @invoice_6.id, credit_card_number: "654498711")
    @transaction_22 = Transaction.create!(result: :failed, invoice_id: @invoice_6.id, credit_card_number: "654498711")

    @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_6.id)
    @invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 0, item_id: @item_5.id, invoice_id: @invoice_6.id)
    @invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 1, item_id: @item_1.id, invoice_id: @invoice_6.id)
  end

  describe 'merchant dashboard page' do
    it "Shows name of merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content(@merchant_1.name)
    end

    it "Shows a link to merchant items and merchant invoices" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_link("Merchant items")
      expect(page).to have_link("Merchant invoices")
    end

    it "shows names of top 5 customers who have conducted largest number of successful transaction with merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("Top 5 customers")
    end

    it "shows number of succesful transaction they have conducted" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect("Meat Loaf").to appear_before("Shannon Dougherty")
      expect("Shannon Dougherty").to appear_before("Puff Daddy")
      expect("Puff Daddy").to appear_before("Walter Wheat")
      expect("Walter Wheat").to appear_before("David Dowie")
    end

    it "see section for items ready to ship" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("Items Ready to Ship")
    end

    it "shows list of items that have been ordered and not shipped" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content("Item name: #{@item_2.name}")
    end

    it "shows invoice id next to each item name" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@invoice_item_7.id)
      expect(page).to have_content(@invoice_item_8.id)
    end

    it "invoice id has links to merchant's invoice show page" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_link("#{@invoice_item_7.id}")
      expect(page).to have_link("#{@invoice_item_8.id}")
    end

    it "shows invoice created date from oldest to newest" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      save_and_open_page
      expect(page).to have_content("Created at: #{@merchant_1.created_at.strftime("%A, %B, %d, %Y")}")
    end
  end
end
