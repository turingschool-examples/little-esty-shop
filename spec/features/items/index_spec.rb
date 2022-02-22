require 'rails_helper'

RSpec.describe 'Item Index page' do 
    before(:each) do 
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant_id: @merchant_1.id)
        @item_2 = create(:item, merchant_id: @merchant_1.id)
        @item_5 = create(:item, merchant_id: @merchant_1.id)
        @merchant_2 = create(:merchant)
        @item_3 = create(:item, merchant_id: @merchant_2.id)
        @item_4 = create(:item, merchant_id: @merchant_2.id)
    end
    it 'will show a list of items that a merchant has' do 
        visit "/merchants/#{@merchant_1.id}/items"
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
        expect(page).to_not have_content(@item_4.name)
    end
    it 'will have links on the name that will direct user to show page of item' do 
        visit "/merchants/#{@merchant_1.id}/items"
        click_on"#{@item_1.name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    end
    it 'will have a section for enabled items' do 
        @item_5.enabled!
        visit "/merchants/#{@merchant_1.id}/items"
        within ".enabled" do 
            expect(page).to have_content(@item_5.name)
        end
        within ".disabled" do 
            expect(page).to have_content(@item_1.name)
        end
    end
    it 'will have a link to add a new item on the page' do 
        visit "/merchants/#{@merchant_1.id}/items"
        expect(page).to have_link('Create Item')
    end
end