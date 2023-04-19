require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items show page' do
    it 'I see all of my items information' do
      visit merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price_to_dollars)
      expect(page).to_not have_content(@item_9.name)

      visit merchant_item_path(@merchant_2, @item_10)

      expect(page).to have_content(@item_10.name)
      expect(page).to have_content(@item_10.description)
      expect(page).to have_content(@item_10.unit_price_to_dollars)
      expect(page).to_not have_content(@item_1.name)
    end

    it 'I see a link to edit the item, when I click the link I am taken to an edit page' do
      visit merchant_item_path(@merchant_1, @item_1)
      click_button('Update Item')

      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))

      visit merchant_item_path(@merchant_2, @item_10)
      click_button('Update Item')

      expect(current_path).to eq(edit_merchant_item_path(@merchant_2, @item_10))
    end
  end
end