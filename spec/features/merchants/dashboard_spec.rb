require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  describe 'Merchant Dashboard' do
    before(:each) do
      @merchant = Merchant.create!(id: 1, name: 'Willms and Sons')
      @item1 = @merchant.items.create!(id: 1, name: "Item 1", description: "An item", unit_price: 1300)
      @item2 = @merchant.items.create!(id: 2, name: "Item 2", description: "Another item", unit_price: 1200)
      @customer1 = Customer.create!(id: 1, first_name: "John", last_name: "Cena")
      @customer2 = Customer.create!(id: 2, first_name: "Anakin", last_name: "Skywalker")
      @invoice1 = @customer1.invoices.create!(id: 1, status: 0)
      @invoice2 = @customer2.invoices.create!(id: 2, status: 2)
      @invoice_item1 = InvoiceItem.create!(id: 1, item_id: @item1.id, invoice_id: @invoice1.id)
      @invoice_item2 = InvoiceItem.create!(id: 2, item_id: @item2.id, invoice_id: @invoice2.id)

      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it 'shows merchant name' do
      # save_and_open_page
      expect(page).to have_content(@merchant.name)
    end

    it 'links to merchant items index' do
      click_on "Items Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'links to merchant invoices index' do
      save_and_open_page
      click_on "Invoices Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end
  end
end
