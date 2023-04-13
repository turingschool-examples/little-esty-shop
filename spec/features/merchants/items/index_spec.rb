require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    test_data
  end

  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see all of my items' do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_9.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    it 'when I click on an item name, I am taken to that merchants items show page' do
      visit merchant_items_path(@merchant_1)
      click_link(@item_1.name)

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    it 'each item name has a button to enable or disable that item' do
      visit merchant_items_path(@merchant_1)
require 'pry'; binding.pry
      within '#enabled-items-list' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_9.name)
      end

        within "#enabled-item-#{@item_1.id}" do
          expect(page).to_not have_button('Enable')
          expect(page).to have_button('Disable')
          
          click_button('Disable')
        end

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      
      within '#disabled-items-list' do
        expect(page).to have_content(@item_1.name)
      end

        within "#disabled-item-#{@item_1.id}" do
          expect(page).to have_button('Enable')
          expect(page).to_not have_button('Disable')
        end
    end
  end
end