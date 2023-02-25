require 'rails_helper'

RSpec.describe "Merchant_Items#Edit", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    
    create(:transaction, invoice_id: @invoice_1.id, result: 0)

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
  end

  describe "User Story 8" do
    it "shows a form filled in with the existing attribute information" do
      save_and_open_page
      expect(page).to have_field("Name", with: @item_1.name)
      expect(page).to have_field("Description", with: @item_1.description)
      expect(page).to have_field("Unit Price", with: @item_1.unit_price)
    end

    xit "allows me to update the item info and submit the form" do

    end
  end
end
