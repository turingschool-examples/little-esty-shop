require 'rails_helper'

RSpec.describe "Merchant Items Show" do
  describe "As a merchant" do

    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:item1) { create(:item, merchant_id: merchant1.id) }
    let!(:item2) { create(:item, merchant_id: merchant1.id) }
    let!(:item3) { create(:item, merchant_id: merchant2.id) }
    let!(:item4) { create(:item, merchant_id: merchant2.id) }

    before do
      visit "/merchants/#{merchant1.id}/items/#{item1.id}"
    end

    # 8. Merchant Item Update
    describe "I see a link to update the item information" do
      it "When I click the link, I am taken to a page to edit this item" do
        expect(page).to have_link("Update #{item1.name}")
        
        click_link("Update #{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")

        fill_in :name, with: "New Item"
        fill_in :description, with: "This is a new item."
        fill_in :unit_price, with: 50

        click_button "Update"

        expect(page).to have_content("New Item")
        expect(page).to have_content("This is a new item.")
        expect(page).to have_content(50)
      end

      it 'sad path, invalid inputs' do
        click_link("Update #{item1.name}")
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")

        fill_in :name, with: "New Item"
        fill_in :description, with: "This is a new item."
        fill_in :unit_price, with: "Text"

        click_button "Update"
        expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")
        expect(page).to have_content("Invalid input")
      end
    end
  end
end