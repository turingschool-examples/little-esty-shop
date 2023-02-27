require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "As a merchant" do

    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:item1) { create(:item, merchant_id: merchant1.id, status: "enabled")}
    let!(:item2) { create(:item, merchant_id: merchant1.id, status: "disabled")}
    let!(:item3) { create(:item, merchant_id: merchant2.id, status: "enabled")}
    let!(:item4) { create(:item, merchant_id: merchant2.id, status: "disabled")}

    before do
      visit "/merchants/#{merchant1.id}/items"
    end
  
    
    describe "When I visit merchants/merchant_id/items" do
      # 6. Merchant Items Index Page
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
    context "When I click on the name of an item, Then I am taken to that merchant's item's show page" do
      it "I should see all of the item's attributes" do
        expect(page).to have_link("#{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items")
        # save_and_open_page
        click_link("#{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
    
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.unit_price.to_f / 100)

        expect(page).to_not have_content(item3.name)
        expect(page).to_not have_content(item3.description)
        expect(page).to_not have_content(item3.unit_price)
      end
    end

    # 10. Merchant Items Grouped by Status
    describe "Then I see two sections, one for Enabled Items and one for Disabled Items" do
      it "I see that each Item is listed in the appropriate section" do
        merchant1 = create(:merchant) 
        merchant2 = create(:merchant) 
        item1 = create(:item, merchant_id: merchant1.id, status: "enabled")
        item2 = create(:item, merchant_id: merchant1.id, status: "disabled")
        item3 = create(:item, merchant_id: merchant1.id, status: "enabled")
        item4 = create(:item, merchant_id: merchant1.id, status: "disabled")

        visit "/merchants/#{merchant1.id}/items"
        
        within "#enabled-item-#{item1.id}" do
          expect(page).to have_button("Disable #{item1.name}")
          expect(page).to_not have_button("Enable #{item1.name}")
        end

        within "#disabled-item-#{item2.id}" do
          expect(page).to have_button("Enable #{item2.name}")
          expect(page).to_not have_button("Disable #{item2.name}")
        end
      end
    end
  end
end
