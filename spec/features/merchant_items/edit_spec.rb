require 'rails_helper'

RSpec.describe 'the merchant item edit' do
  describe 'display' do
    it 'visit' do
      visit edit_merchant_item_path(@merchant1, @item1)
    end
    it 'has a form' do
      visit edit_merchant_item_path(@merchant1, @item1)

      expect(page).to have_content('Name:')
      expect(page).to have_content('Description:')
      expect(page).to have_content('Unit Price:')
      expect(page).to have_button('Update Item')
    end
  end

  describe 'interactable elements' do
    it 'can update item and go back to item show page' do
      visit edit_merchant_item_path(@merchant1, @item1)

      fill_in('Name:', with: 'Oat Milk')
      fill_in('Description:', with: 'A dairy milk alternative, made from oats')
      fill_in('Unit Price:', with: '600')
      click_button('Update Item')

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content('Oat Milk')
      expect(page).to have_content('A dairy milk alternative, made from oats')
      expect(page).to have_content('600')
    end
  end

  describe 'notifications' do
    it 'has a flash message that shows a successful update' do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to_not have_content('Item was successfully updated!')

      click_link("Update #{@item1.name}")

      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))

      fill_in('Name:', with: 'Oat Milk')
      fill_in('Description:', with: 'A dairy milk alternative, made from oats')
      fill_in('Unit Price:', with: '600')
      click_button('Update Item')

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content('Item was successfully updated!')
    end
  end
end
