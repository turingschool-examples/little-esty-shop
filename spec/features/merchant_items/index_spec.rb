require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "when I visit the index page for a merchant's items" do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")
      @merchant2 = Merchant.create!(name: "Adam Etzion")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)

      @item4 = Item.create!(name: "pen of mundanity", description: "fine", unit_price: 55.00, merchant_id: @merchant2.id)
    end

    it "shows a list of the items for only that particular merchant" do

      visit "merchant/#{@merchant1.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).not_to have_content(@item4.name)
    end
  end
end
