require 'rails_helper'

RSpec.describe 'Merchant Item Show Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)

    visit merchant_item_path(@merchant_1.id, @item_1)
  end

  describe 'Merchant Item Show Page (User Story 7)' do
    it 'has a header with a link back to the merchant dashboard' do
      expect(page).to have_content("#{@merchant_1.name} Item Details")
      expect(page).to have_link(@merchant_1.name)
    end

    it 'it has a link to the merchant item index' do
      expect(page).to have_link("#{@merchant_1.name} Item Index")

      click_link("#{@merchant_1.name} Item Index")

      expect(current_path).to eq(merchant_items_path(@merchant_1.id))
    end

    it 'displays the details of the item' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Current Unit Price: #{@item_1.unit_price}")
    end
  end
end
