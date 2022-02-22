require 'rails_helper'

RSpec.describe 'Item Index page' do 
    before(:each) do 
        @merchant_1 = create(:merchant)
    end
    it 'will have a link on the index page that will redirect it to new item form' do 
        visit "/merchants/#{@merchant_1.id}/items"
        click_link("Create Item")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
        fill_in("name", with: "Piano")
        fill_in("description", with: "A beautiful 1930 restored Bosendorfer concert grand")
        fill_in("unit_price", with: 432480)
        click_on("Submit")
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
        expect(page).to have_content("Piano")
    end
end