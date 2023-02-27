require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "As a merchant" do

    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:item1) { create(:item, merchant_id: merchant1.id, unit_price: 100000) }
    let!(:item2) { create(:item, merchant_id: merchant1.id) }
    let!(:item3) { create(:item, merchant_id: merchant2.id) }
    let!(:item4) { create(:item, merchant_id: merchant2.id) }

    before do
      visit "/merchants/#{merchant1.id}/items"
    end
  
    # 6. Merchant Items Index Page
    describe "When I visit merchants/merchant_id/items" do
      it "I see a list of the names of all of my items, And I do not see items for any other merchant" do
        expect(page).to have_content("#{merchant1.name}")
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item2.name)
     
        expect(page).to_not have_content("#{merchant2.name}")
        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(item4.name)
      end
    end

    # 7. Merchant Items Show Page
    describe "When I click on the name of an item, Then I am taken to that merchant's item's show page" do
      it "I should see all of the item's attributes" do
        expect(page).to have_link("#{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items")

        click_link("#{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")

        expect(page).to have_content(item1.name)
        expect(page).to have_content(item1.description)
        expect(page).to have_content('$1,000.00')

        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(item3.description)
        expect(page).to_not have_content(item3.unit_price)
      end
    end

    # 9. Merchant Item Disable/Enable
    describe 'When I visit my items index page' do
      it 'Next to each item name I see a button to disable or enable that item.' do

        expect(page).to have_button("Disable")
        expect(page).to have_button("Enable")
      
      end

      it "When I click this button. Then I am redirected back to the items index, and I see that the items status has changed" do

        within "#item-#{item1.id}" do
          click_button('Enable')
        end

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")

        within "#item-#{item1.id}" do
          expect(page).to have_content("Status: enabled")
          click_button("disable")
        end

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")
        
        within "#item-#{item1.id}" do
          expect(page).to have_content("Status: disabled")
        end
      end
    end

    # 11. Merchant Item Create - cont'd in 'spec/features/items/new_spec.rb
    describe 'When I visit my items index page' do
      it 'I see a link to create a new item.' do
        expect(page).to have_link("Create a New Item")
      end

      it 'When I click the link "Create New Item" button I am redirected to a new page create a new Item' do
        click_on("Create a New Item")

        expect(current_path).to eq("/merchants/#{merchant1.id}/items/new")
      end
    end
  end
end