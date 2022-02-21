require 'rails_helper'

RSpec.describe 'Item Show page' do 
    before(:each) do 
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant_id: @merchant_1.id)
        @item_2 = create(:item, merchant_id: @merchant_1.id)
        @merchant_2 = create(:merchant)
        @item_3 = create(:item, merchant_id: @merchant_2.id)
        @item_4 = create(:item, merchant_id: @merchant_2.id)
    end
    it 'will have name, description, and price on the show page' do 
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
        expect(page).to have_content(@item_1.unit_price)
        expect(page).to have_content(@item_1.description)
        expect(page).to have_content(@item_1.name)
    end
    it 'will have a link to edit the item that will redirect to the edit page' do 
         visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
        click_link "Edit item"
        expect(current_path).to eq("/merchants/#{@item_1.merchant.id}/items/#{@item_1.id}/edit")
    end
end
