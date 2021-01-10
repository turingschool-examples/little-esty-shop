require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit a merchant's item's show page (/merchant/merchant_id/items/item_id)" do
    before :each do
      @max = Merchant.create!(name: 'Merch Max')
      @item_1 = @max.items.create!(name: 'Beans', description: 'Tasty', unit_price: 5)

      visit "merchants/#{@max.id}/items/#{@item_1.id}"
    end

    it "I see all of the item's attributes including: Name, Description, and Current Selling Price" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Price: #{@item_1.unit_price}")
    end
  end
end
