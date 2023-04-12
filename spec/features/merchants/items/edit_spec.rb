require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items edit page' do
    it 'I see a form to edit the item' do
      visit edit_merchant_item_path(@merchant_1, @item_1)

      expect(find_field('Name').value).to eq(@item_1.name)
      expect(find_field('Description').value).to eq(@item_1.description)
      expect(find_field('Unit price').value).to eq(@item_1.unit_price_to_dollars)
      expect(page).to have_button('Submit')

      visit edit_merchant_item_path(@merchant_2, @item_10)

      expect(find_field('Name').value).to eq(@item_10.name)
      expect(find_field('Description').value).to eq(@item_10.description)
      expect(find_field('Unit price').value).to eq(@item_10.unit_price_to_dollars)
      expect(page).to have_button('Submit')
    end

    it 'When I update and click submit, I am taken to the item show page' do
      visit edit_merchant_item_path(@merchant_1, @item_1)
      fill_in 'Name', with: 'New Item Name'
      fill_in 'Description', with: 'New Item Description'
      fill_in 'Unit price', with: 1100
      click_button('Submit')

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content('Item Updated')
      expect(page).to have_content('New Item Name')
      expect(page).to have_content('New Item Description')
      expect(page).to have_content('11')

      visit edit_merchant_item_path(@merchant_2, @item_10)
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'New Item Description'
      fill_in 'Unit price', with: 1100
      click_button('Submit')

      expect(current_path).to eq(edit_merchant_item_path(@merchant_2, @item_10))
      expect(page).to have_content('Item Update Failed')
    end
  end
end