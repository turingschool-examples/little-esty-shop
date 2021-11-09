require 'rails_helper'

RSpec.describe "Merchant Items Edit Page" do
  before do
    @merchant = Merchant.create!(name: 'Willms and Sons')
    @item = @merchant.items.create!(name: "Item 1", description: "An item", unit_price: 1300)

    visit edit_merchant_item_path(@merchant, @item)
  end

  describe "Merchant Items Edit Page" do
    it 'has a form to update the item' do
      within '#form' do
        expect(find_field('item_name').value).to eq(@item.name)

        fill_in 'Name', with: 'eeeyy item'

        click_button 'Submit'
      end

      expect(current_path).to eq(merchant_item_path(@merchant, @item))
      expect(page).to have_content('eeeyy item')
      expect(page).to have_content('Successfully Update Item')
    end
  end
end
