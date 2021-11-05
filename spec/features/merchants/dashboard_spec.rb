require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  describe 'Merchant Dashboard' do
    before(:each) do
      @merchant = Merchant.create!(id: 1, name: 'Willms and Sons')
      @item1 = @merchant.items.create!(id: 1, name: "Item 1", description: "An item", unit_price: 1300)
      @item2 = @merchant.items.create!(id: 2, name: "Item 2", description: "Another item", unit_price: 1200)
      @customer1 = Customer.create!(id: 1, first_name: "John", last_name: "Cena")
      @customer2 = Customer.create!(id: 2, first_name: "Anakin", last_name: "Skywalker")
      @customer3 = Customer.create!(id: 3, first_name: "Luke", last_name: "Jones")
      @customer4 = Customer.create!(id: 4, first_name: "Leah", last_name: "Smith")
      @customer5 = Customer.create!(id: 5, first_name: "Jar Jar", last_name: "Anderson")
      @customer6 = Customer.create!(id: 6, first_name: "Hank", last_name: "Person")
      @invoice1 = @customer1.invoices.create!(id: 1, status: 1)
      @invoice2 = @customer2.invoices.create!(id: 2, status: 1)
      @invoice3 = @customer3.invoices.create!(id: 3, status: 1)
      @invoice4 = @customer4.invoices.create!(id: 4, status: 1)
      @invoice5 = @customer5.invoices.create!(id: 5, status: 1)
      @invoice6 = @customer6.invoices.create!(id: 6, status: 0)
      @invoice7 = @customer1.invoices.create!(id: 7, status: 1)
      @invoice8 = @customer2.invoices.create!(id: 8, status: 1)
      @invoice9 = @customer3.invoices.create!(id: 9, status: 1)
      @invoice10 = @customer4.invoices.create!(id: 10, status: 1)
      @invoice11 = @customer5.invoices.create!(id: 11, status: 2)
      @invoice12 = @customer6.invoices.create!(id: 12, status: 2)
      @invoice13 = @customer1.invoices.create!(id: 13, status: 1)
      @invoice14 = @customer2.invoices.create!(id: 14, status: 1)
      @invoice15 = @customer3.invoices.create!(id: 15, status: 1)
      @invoice_item1 = InvoiceItem.create!(id: 1, item_id: @item1.id, invoice_id: @invoice1.id)
      @invoice_item2 = InvoiceItem.create!(id: 2, item_id: @item2.id, invoice_id: @invoice2.id)

      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it 'shows merchant name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'links to merchant items index' do
      click_on "Items Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'links to merchant invoices index' do
      click_on "Invoices Index"

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    describe 'favorite customers' do
      xit 'i see names for top 5 customers' do
        expect(page).to have_content("Top 5 Customers:" )
        expect(@customer1.name).to appear_before(@customer2.name)
        expect(@customer2.name).to appear_before(@customer3.name)
        expect(@customer3.name).to appear_before(@customer4.name)
        expect(@customer4.name).to appear_before(@customer5.name)
        expect(page).to_not have_content(@customer6.name)
      end

      it 'i see number of successful transactions next to each customer' do

        
      end
    end
  end
end
