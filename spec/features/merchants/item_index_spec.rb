require 'rails_helper'

RSpec.describe "Merchant Items Index" do
  describe "As a merchant" do

    let!(:merchant1) { create(:merchant) }
    let!(:merchant2) { create(:merchant) }
    let!(:item1) { create(:item, merchant_id: merchant1.id) }
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
  end
end