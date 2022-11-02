require 'rails_helper'

  RSpec.describe 'Admin Index' do
    before :each do 
      @customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
      @customer_2 = Customer.create!(first_name: "Evan", last_name: "East")
      @customer_3 = Customer.create!(first_name: "Yasha", last_name: "West")
      @customer_4 = Customer.create!(first_name: "Du", last_name: "North")
      @customer_5 = Customer.create!(first_name: "Polly", last_name: "South")
      
      @item_1 = Items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 500, merchant_id: @merchant_1.id)
      @item_2 = Items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000, merchant_id: @merchant_2.id)
      @item_3 = Items.create!(name: "Orion Flag", description: "A flag of Okinawa's most popular beer", unit_price: 850, merchant_id: @merchant_3.id)

      @invoice_1 = Invoice.create!(status: "In Progress", customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: "Canceled", customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: "Completed", customer_id: @customer3.id)
      @invoice_4 = Invoice.create!(status: "In Progress", customer_id: @customer_4.id)

      @merchant_1 = Merchant.create!(name: "Shawn LLC")
      @merchant_2 = Merchant.create!(name: "Naomi LLC")
      @merchant_3 = Merchant.create!(name: "Kristen LLC")
      @merchant_4 = Merchant.create!(name: "Yuji LLC")
      @merchant_5 = Merchant.create!(name: "Turing LLC")

      visit '/admin'
    end

    it "has a header" do 
      expect(page).to have_content("Admin Dashboard")
    end

    it "has links" do 
      expect(page).to have_link('admin merchants index')
      expect(page).to have_link('admin invoices index')
    end

    it 'has a section for "Incomplete Invoices' do 
      expect(page).to have_content("Incomplete Invoices")
      
    end 
end