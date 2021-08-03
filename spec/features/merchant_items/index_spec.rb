require 'rails_helper'

RSpec.describe 'the merchant items index' do
  describe 'display' do
    it 'visit' do
      visit merchant_items_path(@merchant1)
    end

    it 'displays merchant name and items' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content('Costco')
      expect(page).to have_content('Milk')
      expect(page).to have_content('Potato Chips')
      expect(page).to have_content('Hot Dog')
      expect(page).to have_content('Steaks')
      expect(page).to_not have_content('Frying Pan')
    end

    it 'has item names that are links' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link('Milk')
    end

    it 'has an enable button for items that are disabled' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content('Status: Disabled')
      expect(page).to have_button('Enable')
    end

    xit 'has a disable link for items that are enabled' do

    end
  end

  describe 'interactable elements' do
    it 'can click on item link and be taken to its show page' do
      visit merchant_items_path(@merchant1)

      click_link('Milk')

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content('Milk')
      expect(page).to have_content('A large quantity of whole milk')
      expect(page).to have_content('500')
    end

    it 'can click on enable button and enable disabled item' do
      visit merchant_items_path(@merchant1)
      expect(page).to_not have_content('Status: Enabled')

      click_button('Enable Milk')

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(page).to have_content('Status: Enabled')
    end
  end
end
