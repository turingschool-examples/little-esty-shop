require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)

    visit merchant_items_path(@merchant_1.id)
  end

  describe 'Merchant Items Index Page (User Story 6)' do
    it 'has a header' do
      expect(page).to have_content("#{@merchant_1.name} Items")
    end

    it 'it lists all of the merchan item names as links' do
      visit merchant_items_path(@merchant_1)

      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
      end
    end

    it 'does not display items from any other merchant' do
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)

      expect(page).to_not have_link(item_2.name)
    end
  end
end
