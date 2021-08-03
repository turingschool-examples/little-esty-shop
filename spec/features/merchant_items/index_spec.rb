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

      expect(page).to have_button('Enable')
    end

    it 'has a disable link for items that are enabled' do
      visit merchant_items_path(@merchant1)
      expect(page).to_not have_button('Disable Milk')
      click_button('Enable Milk')

      expect(page).to have_button('Disable Milk')
    end

    it 'has a button to make a new merchant item' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_button('Create a New Item')
    end
  end

  describe 'interactable elements' do
    it 'can click on item link and be taken to its show page' do
      visit merchant_items_path(@merchant1)

      first(:link, 'Milk').click

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content('Milk')
      expect(page).to have_content('A large quantity of whole milk')
      expect(page).to have_content('500')
    end

    it 'can click on enable button and enable disabled item' do
      visit merchant_items_path(@merchant1)

      click_button('Enable Milk')

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(page).to have_content('Status: Enabled')
      expect('Enabled Items').to appear_before('Milk')
      expect('Milk').to appear_before('Disabled Items')
    end

    it "can click on 'Create a New Item' button and be taken to the new page " do
      visit merchant_items_path(@merchant1)

      click_button('Create a New Item')

      expect(current_path).to eq(new_merchant_item_path(@merchant1))
    end
  end
end
