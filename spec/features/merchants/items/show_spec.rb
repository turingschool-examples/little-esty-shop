require 'rails_helper'

RSpec.describe 'Merchant Items Show' do
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

        @item_1 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id)
        @item_2 = Item.create!(name: "Challah", description: "So delicious", unit_price: 10, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Wonder Bread", description: "Basic", unit_price: 3, merchant_id: @merchant_1.id)
    end

    it 'shows attributes of item' do
        visit "/merchant/#{@merchant_2.id}/items/#{@item_1.id}"

        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content(@item_1.unit_price)
        expect(page).to_not have_content(@item_2.name)
    end

    it 'has link to update item' do
        visit "/merchant/#{@merchant_2.id}/items/#{@item_1.id}"

        expect(page).to have_link("Update #{@item_1.name}")
        click_link "Update #{@item_1.name}"

        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items/#{@item_1.id}/edit")
    end
end