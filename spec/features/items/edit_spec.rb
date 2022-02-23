require 'rails_helper'

RSpec.describe 'Item update page' do 
    before(:each) do 
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant_id: @merchant_1.id)
    end
    it 'will have name, description, and price on the show page' do 
       visit "/merchants/#{@item_1.merchant.id}/merchant_items/#{@item_1.id}/edit"
       fill_in "name", with: "Yo-yo"
       click_button "Submit"
       expect(current_path).to eq("/merchants/#{@merchant_1.id}/merchant_items/#{@item_1.id}")
       expect(page).to have_content('Yo-yo')
    end
end