require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

        @item_1 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id)
        @item_2 = Item.create!(name: "Challah", description: "So delicious", unit_price: 10, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Wonder Bread", description: "Basic", unit_price: 3, merchant_id: @merchant_1.id)
    end
    
    it 'shows the name of all the items of the merchant' do
        visit "/merchant/#{@merchant_2.id}/items"

        expect(page).to have_content("Carrie Breadshaw")
        expect(page).to have_content("Rye")
        expect(page).to have_content("Challah")
        expect(page).to_not have_content("Bread Pitt")
        expect(page).to_not have_content("Wonder Bread")
    end

    it 'has a link to the show page of each merchant item' do
        visit "/merchant/#{@merchant_2.id}/items"

        expect(page).to have_link(@item_1.name)
        expect(page).to have_link(@item_2.name)
        click_link "#{@item_1.name}"

        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items/#{@item_1.id}")
    end
end