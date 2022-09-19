require 'rails_helper'

RSpec.describe 'Merchant Items Edit' do
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

        @item_1 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id)
        @item_2 = Item.create!(name: "Challah", description: "So delicious", unit_price: 10, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Wonder Bread", description: "Basic", unit_price: 3, merchant_id: @merchant_1.id)
    end

    it 'edit form prepopulates item info' do
        visit "/merchant/#{@merchant_2.id}/items/#{@item_1.id}/edit"

        expect(page).to have_field("Item", with: "#{@item_1.name}")
        expect(page).to have_field("Description", with: "#{@item_1.description}")
        expect(page).to have_field("Unit Price", with: "#{@item_1.unit_price}")
        expect(page).to_not have_field("Item", with: "#{@item_2.name}")
    end

    it 'can update item info' do
        visit "/merchant/#{@merchant_2.id}/items/#{@item_1.id}/edit"

        fill_in "Item", with: "Organic Rye"
        fill_in "Description", with: "100% organic ingredients"
        fill_in "Unit Price", with: "12"
        click_button "Submit"

        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items/#{@item_1.id}")
        expect(page).to have_content("Organic Rye")
        expect(page).to have_content("Update successful")
    end
end