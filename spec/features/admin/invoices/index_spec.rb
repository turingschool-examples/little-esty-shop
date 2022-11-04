require 'rails_helper'

  RSpec.describe 'Admin Invoices Index' do
    before :each do 
      @merchant_1 = Merchant.create!(name: "Shawn LLC")
      @merchant_2 = Merchant.create!(name: "Naomi LLC")
      @merchant_3 = Merchant.create!(name: "Kristen LLC")
      @merchant_4 = Merchant.create!(name: "Yuji LLC")
      @merchant_5 = Merchant.create!(name: "Turing LLC")
      
      @customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
      @customer_2 = Customer.create!(first_name: "Evan", last_name: "East")
      @customer_3 = Customer.create!(first_name: "Yasha", last_name: "West")
      @customer_4 = Customer.create!(first_name: "Du", last_name: "North")
      @customer_5 = Customer.create!(first_name: "Polly", last_name: "South")
      @customer_6 = Customer.create!(first_name: "Dolly", last_name: "North")
      
      @item_1 = Item.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850, merchant_id: @merchant_3.id)
      
      @invoice_1 = Invoice.create!(status: "in progress", customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: "cancelled", customer_id: @customer_1.id)
      @invoice_3 = Invoice.create!(status: "completed", customer_id: @customer_1.id)
      @invoice_4 = Invoice.create!(status: "in progress", customer_id: @customer_2.id)
      @invoice_5 = Invoice.create!(status: "in progress", customer_id: @customer_4.id)
      @invoice_6 = Invoice.create!(status: "in progress", customer_id: @customer_2.id)
      
      @invoice_items_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 11, status: "shipped", created_at: Time.parse("22.11.02"))
      @invoice_items_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 11, status: "packaged", created_at: Time.parse("22.11.06"))
      @invoice_items_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 11, status: "pending", created_at: Time.parse("22.11.04"))
      @invoice_items_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 11, status: "packaged", created_at: Time.parse("22.11.08"))
      @invoice_items_5 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 11, status: "pending", created_at: Time.parse("22.11.03"))
      @invoice_items_6 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 11, status: "shipped", created_at: Time.parse("22.11.09"))
      
      @transaction_1 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: 1111111111111111, credit_card_expiration_date: "11/11", result: "success", invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: 2222222222222222, credit_card_expiration_date: "01/11", result: "success", invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: 3333333333333333, credit_card_expiration_date: "01/21", result: "success", invoice_id: @invoice_6.id)
      
      visit "/admin/invoices"
      
    end

    it "has a header" do 
      expect(page).to have_content("Admin Invoices Index")
    end

    it "has invoice ID links" do 
      expect(page).to have_link(@invoice_1.id)
      expect(page).to have_link(@invoice_2.id)
      expect(page).to have_link(@invoice_3.id)
      expect(page).to have_link(@invoice_4.id)
      expect(page).to have_link(@invoice_5.id)
      click_link(@invoice_2.id)
      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
    end
  end 