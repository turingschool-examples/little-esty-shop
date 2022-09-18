require 'rails_helper'

RSpec.describe 'Merchant Item Create' do
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

        @item_1 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id, status: :Enabled)
        @item_2 = Item.create!(name: "Challah", description: "So delicious", unit_price: 10, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Wonder Bread", description: "Basic", unit_price: 3, merchant_id: @merchant_1.id)
    end

    it 'can create new items' do
      visit "/merchant/#{@merchant_2.id}/items/new"

      fill_in "Name", with: "Cinnamon Roll"
      fill_in "Description", with: "Everyone's favorite breakfast treat"
      fill_in "Unit price", with: "6"
      click_button "Submit"

      expect(current_path).to eq("/merchant/#{@merchant_2.id}/items")

      within '.disabled' do
        expect(page).to have_content("Cinnamon Roll")
      end

      within '.enabled' do
        expect(page).to_not have_content("Cinnamon Roll")
      end
    end
end