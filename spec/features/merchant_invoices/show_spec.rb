require 'rails_helper'

RSpec.describe 'merchant invoice show page' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @merchant_2 = Merchant.create!(name: 'Chris')

    @item_1 = @merchant.items.create!(name: 'Bottle', unit_price: 100, description: 'H20')
    @item_2 = @merchant.items.create!(name: 'Can', unit_price: 500, description: 'Soda')
    @item_3 = @merchant_2.items.create!(name: 'Jar', unit_price: 400, description: 'Jelly')

    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
    @invoice_1 = @customer.invoices.create!(status: "in progress", created_at: Time.parse("2022-04-12 09:54:09"))
    @invoice_1.invoice_items.create!(item_id: @item_1.id, status: "shipped", quantity: 8, unit_price: 100)
    @invoice_1.invoice_items.create!(item_id: @item_2.id, status: "packaged", quantity: 5, unit_price: 500)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

  it "displays information related to the invoice" do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content("in progress")
    expect(page).to have_content("Tuesday, April 12, 2022")
    expect(page).to have_content("Billy")
    expect(page).to have_content("Jonson")
  end

  context 'invoice items' do
    it 'should show the names of all items related to the invoice' do
      expect(page).to have_content("Bottle")
      expect(page).to have_content("Can")
      expect(page).to_not have_content("Jar")
    end

    it 'next to each item should be its quantity, price, and invoice_item status' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Quantity: 8")
        expect(page).to have_content("Price per Item: $1.00")
        expect(page).to have_content("Status: shipped")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Quantity: 5")
        expect(page).to have_content("Price per Item: $5.00")
        expect(page).to have_content("Status: packaged")
      end
    end

    it "displays the total revenue for all items on the invoice" do
      @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
      @item_2.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
      @item_3.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
      expect(page).to have_content("Total Revenue: $33.00")
    end

    it 'displays a select box to change an invoice_item status' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Status: shipped")
      end
      
      within "#item-#{@item_1.id}" do
        select 'packaged', from: 'select_status'
        click_button "Update Item Status"
      end

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Status: packaged")
      end
    end
  end
end
