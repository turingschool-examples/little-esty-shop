require 'rails_helper'

RSpec.describe "Merchant Items Edit Page" do
  before do
    @merchant = Merchant.create!(name: 'Willms and Sons')
    @item = @merchant.items.create!(name: "Item 1", description: "An item", unit_price: 1300)

    visit edit_merchant_item_path(@merchant, @item)
  end

  describe "Merchant Items Edit Page" do
    it 'has a form to update the item' do
      fill_in "Name", with: 'first item'
      click_button 'Submit'
      expect(current_path).to eq(merchant_item_path(@merchant, @item))
      expect(page).to have_content('first item')
      # expect(page).to have_content('Successfully Updated')
    end
  end
end
