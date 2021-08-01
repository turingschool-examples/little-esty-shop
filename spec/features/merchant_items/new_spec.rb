require 'rails_helper'

RSpec.describe 'the merchant item creation' do
  describe 'display' do
    it 'visit' do
      visit merchant_items_path(@merchant1)
      click_button('Create a New Item')
      expect(current_path).to eq(new_merchant_item_path(@merchant1))
    end
    it 'has a form' do
      visit merchant_items_path(@merchant1)
      click_button('Create a New Item')

      expect(page).to have_content('Name:')
      expect(page).to have_content('Description:')
      expect(page).to have_content('Unit Price:')
      expect(page).to have_button('Create Item')
    end
  end

  describe 'interactable elements' do
    it 'can create item and go back to merchant item index page' do
      visit merchant_items_path(@merchant1)
      click_button('Create a New Item')

      fill_in('Name:', with: 'MacBook Pro M1')
      fill_in('Description:', with: 'A laptop computer from Apple')
      fill_in('Unit Price:', with: '120_000')
      click_button('Create Item')

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(page).to have_content('MacBook Pro M1')
    end
  end

  describe 'notifications' do
  end
end
