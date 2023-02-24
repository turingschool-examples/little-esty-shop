require 'rails_helper'

RSpec.describe 'merchant invoice show' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mel's Travels")
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack")
    @merchant_3 = Merchant.create!(name: "Huy's Cheese")

    @item_1 = Item.create!(name: "Salt", description: "it is salty", unit_price: 12, merchant: @merchant_1)
    @item_2 = Item.create!(name: "Pepper", description: "it is peppery", unit_price: 11, merchant: @merchant_1)
    @item_3 = Item.create!(name: "Spices", description: "it is spicy", unit_price: 13, merchant: @merchant_1)
    @item_4 = Item.create!(name: "Sand", description: "its all over the place", unit_price: 14, merchant: @merchant_2)
    @item_5 = Item.create!(name: "Water", description: "see item 1, merchant 1", unit_price: 15, merchant: @merchant_2)
    @item_6 = Item.create!(name: "Rum", description: "good for your health", unit_price: 33, merchant: @merchant_2)
    @item_7 = Item.create!(name: "American", description: "gud cheese", unit_price: 34, merchant: @merchant_3)
    @item_8 = Item.create!(name: "Swiss", description: "holes in cheese", unit_price: 92, merchant: @merchant_3)
    @item_9 = Item.create!(name: "Cheddar", description: "SHARP!", unit_price: 1123, merchant: @merchant_3)
    @item_10 = Item.create!(name: "Imaginary", description: "it is whatever you think it is", unit_price: 442, merchant: @merchant_3)
    
    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
    @customer_2 = Customer.create!(first_name: "Steve", last_name: "Stevinson")
    
    @invoice_1 = Invoice.create!(customer: @customer_1)
    @invoice_2 = Invoice.create!(customer: @customer_2, status: 0)


    InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: @item_1.unit_price)
    InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: @item_2.unit_price)

  end

  describe 'mercants invoices show' do
    it 'shows all invoices with links to their show page' do
      visit "merchants/#{@merchant_1.id}/invoices"

      click_link("#{@invoice_1.id}")
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at)
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)

      visit "merchants/#{@merchant_1.id}/invoices"

      click_link("#{@invoice_2.id}")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_2.id}")
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_2.status)
      expect(page).to have_content(@invoice_2.created_at)
      expect(page).to have_content(@invoice_2.customer.first_name)
      expect(page).to have_content(@invoice_2.customer.last_name)
    
    end

    it 'shows item with attributes' do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.items.first.name)
      expect(page).to have_content(@invoice_1.invoice_items.first.quantity)
      expect(page).to have_content(@invoice_1.items.first.unit_price)
      expect(page).to have_content(@invoice_1.invoice_items.first.status)
      
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_2.id}"

      expect(page).to have_content(@invoice_2.items.first.name)
      expect(page).to have_content(@invoice_2.invoice_items.first.quantity)
      expect(page).to have_content(@invoice_2.items.first.unit_price)
      expect(page).to have_content(@invoice_2.invoice_items.first.status)
    end

    it 'shows total revenue' do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.total_revenue)
    end
  end
end