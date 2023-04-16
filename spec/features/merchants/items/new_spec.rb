require 'rails_helper'

RSpec.describe 'Merchant Items New Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items new page' do
    it 'I see a form to add a new item' do
      visit new_merchant_item_path(@merchant_1)

      expect(page).to have_content('Add New Item')

      within '#new-item-form' do
        expect(page).to have_field('Name')
        expect(page).to have_field('Description')
        expect(page).to have_field('Unit Price')
        expect(page).to have_button('Submit')
      end
    end

    it 'I can fill out the form and submit it to create a new item' do
      visit new_merchant_item_path(@merchant_1)

      within '#new-item-form' do
        fill_in 'Name', with: 'Banana'
        fill_in 'Description', with: 'Bananarama'
        fill_in 'Unit Price', with: 10000
        click_button 'Submit'
      end

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(page).to have_content('Item Created')
      within '#enabled-items-list' do
        expect(page).to have_content('Banana')
      end
    end

    it 'I cannot create an item without a name, description, and unit price' do
      visit new_merchant_item_path(@merchant_1)

      within '#new-item-form' do
        click_button 'Submit'
      end

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
      expect(page).to have_content("Item Creation Failed")
    end
  end
end