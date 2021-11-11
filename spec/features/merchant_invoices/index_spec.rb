
require "rails_helper"

RSpec.describe "merchant's invoices index", type: :feature do
  describe "when I visit my merchant's invoices index" do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @item_1 = @merchant.items.create(name: 'YoYo', description: 'its on a string', unit_price: 1000)
      @item_2 = @merchant.items.create(name: 'raisin', description: 'dried grape', unit_price: 100)
      @item_3 = @merchant.items.create(name: 'apple', description: 'nice and crisp', unit_price: 500)
      @item_4 = @merchant.items.create(name: 'banana', description: 'mushy but good', unit_price: 200)
      @item_5 = @merchant.items.create(name: 'pear', description: 'refreshing treat', unit_price: 600)

      @customer = Customer.create(first_name: 'George', last_name: 'Washington')

      @invoice_1 = @customer.invoices.create(status: 'Completed')
      @invoice_2 = @customer.invoices.create(status: 'Completed')

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 3, unit_price: 1000, status: 'shipped')
      @invoice_item_2 = @invoice_1.invoice_items.create(item_id: @item_2.id, quantity: 1, unit_price: 100, status: 'shipped')
      @invoice_item_3 = @invoice_1.invoice_items.create(item_id: @item_3.id, quantity: 1, unit_price: 400, status: 'shipped')
      @invoice_item_4 = @invoice_2.invoice_items.create(item_id: @item_4.id, quantity: 1, unit_price: 200, status: 'shipped')
      @invoice_item_5 = @invoice_2.invoice_items.create(item_id: @item_5.id, quantity: 1, unit_price: 600, status: 'shipped')

      visit "/merchants/#{@merchant.id}/invoices"

    end

    it "I see all the invoices that has merchant's items" do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_2.id}")
    end

    it "I see invoice_id for each invoice, which links to merchant invoice show page" do
      click_on "Invoice ##{@invoice_1.id}"
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    end
  end
end
