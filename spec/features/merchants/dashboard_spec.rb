require 'rails_helper'

RSpec.describe Merchant, type: :feature do
  describe "Merchant Dashboard" do
    before :each do
      @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragdolls")
      @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
      @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")

      @item_1 = @merchant_1.items.create!(name: "Twinkies", description: "Yummy", unit_price: 400)
      @item_2 = @merchant_1.items.create!(name: "Applesauce", description: "Yummy", unit_price: 400)
      @item_3 = @merchant_1.items.create!(name: "Milk", description: "Yummy", unit_price: 400)
      @item_4 = @merchant_1.items.create!(name: "Bread", description: "Yummy", unit_price: 400)
      @item_5 = @merchant_1.items.create!(name: "Ice Cream", description: "Yummy", unit_price: 400)
      @item_6 = @merchant_1.items.create!(name: "Waffles", description: "Yummy", unit_price: 400)

      @customer_1 = Customer.create!(first_name: "Regina", last_name: "Last Name")
      @customer_2 = Customer.create!(first_name: "Jennifer", last_name: "Last Name")
      @customer_3 = Customer.create!(first_name: "Mark", last_name: "Last Name")
      @customer_4 = Customer.create!(first_name: "Caleb", last_name: "Last Name")
      @customer_5 = Customer.create!(first_name: "Richard", last_name: "Last Name")
      @customer_6 = Customer.create!(first_name: "Zach", last_name: "Last Name")

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "in progress")
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
      @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
      @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
      @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 1)

      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1500, status: "pending")
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 1500, status: 0)

      Transaction.create!(invoice_id: @invoice_2.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
      Transaction.create!(invoice_id: @invoice_3.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
      Transaction.create!(invoice_id: @invoice_4.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
      Transaction.create!(invoice_id: @invoice_5.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
      Transaction.create!(invoice_id: @invoice_6.id, result: 0, credit_card_number: '12345', credit_card_expiration_date: '12345')
    end

    it "should display name of merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("#{@merchant_1.name}")
      expect(page).to_not have_content("#{@merchant_2.name}")
    end

    it "should contain links to merchant items index and merchant invoices index" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_button("Dashboard")
      expect(page).to have_button("My Items")
      expect(page).to have_button("My Invoices")
      click_button("My Items")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_button("My Invoices")
      click_button("My Invoices")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end

    #     Merchant Dashboard Statistics - Favorite Customers
    #
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant

    it "should list top 5 customers per merchant" do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      expect(page).to have_content("Top 5 Customer")
      expect(page).to have_content("Successful Transactions 3")
      expect(page).to have_content("Successful Transactions 2")
      expect(page).to have_content("Successful Transactions 1")
      expect(page).to have_content("1. Zach Last Name")
      expect(page).to have_content("2. Richard Last Name")
      expect(page).to have_content("3. Jennifer Last Name")
      expect(page).to have_content("4. Mark Last Name")
      expect(page).to have_content("5. Caleb Last Name")
    end

  end
end
