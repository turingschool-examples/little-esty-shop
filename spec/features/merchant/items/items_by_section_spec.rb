require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items'" do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id, status: true)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id, status: true)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id, status: true)
    @item6 = create(:item, merchant_id: @merchant1.id)
  end
  describe 'it displays items sorted by status' do
    it 'shows enabled and disabled items' do
      visit merchant_items_path(@merchant1)

      within(".enabled_items") do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item3.name)
        expect(page).to have_content(@item5.name)
      end

      within(".disabled_items") do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item4.name)
        expect(page).to have_content(@item6.name)
      end
    end
  end
end
  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
