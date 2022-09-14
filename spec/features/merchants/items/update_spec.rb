require 'rails_helper'

RSpec.describe 'merchant item edit page' do
  before :each do
    @merchant = Merchant.create!(name: 'George Smith')
    @item = @merchant.items.create!(name: 'Super Ball', description: 'A bouncy rubber ball.', unit_price: 300)
  end
  describe 'page content' do
    it 'shows a form to edit the item' do
      visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit price')
    end
    it 'shows the form prefilled with the current item values' do
      visit "/merchants/#{@merchant.id}/items/#{@item.id}/edit"

      expect(find('form')).to have_field('Name', with: 'Super Ball')
      expect(find('form')).to have_field('Description', with: 'A bouncy rubber ball.')
      expect(find('form')).to have_field('Unit price', with: '300')
    end
  end
  context 'valid data was submitted' do
    it 'updates the item when the form is submitted and redirects to the item show page' do
      visit edit_merchant_item_path(@merchant.id, @item.id)

      fill_in 'Name', with: 'Rocket Ball'
      click_button 'Save'

      expect(page).to have_current_path(merchant_item_path(@merchant.id, @item.id))
      expect(page).to have_content('Rocket Ball')
      expect(page).to_not have_content('Super Ball')
      expect(page).to have_content('Item updated successfully')
    end
  end
  context 'invalid data was submitted' do
    it 'redirects to the edit page and displays an error message' do
      visit edit_merchant_item_path(@merchant.id, @item.id)

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_current_path(visit edit_merchant_item_path(@merchant.id, @item.id))
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end