require 'rails_helper'

RSpec.describe 'edit merchant items show page' do
  describe 'I see a link to update the item information' do
    it 'displays link' do
      merchant = Merchant.create!(name: 'Yeti')

      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')

      visit "/merchants/#{merchant.id}/items/#{item_1.id}"
      click_link "Edit #{item_1.name}"
      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item_1.id}/edit")
    end
    it 'displays the form to edit a specfic merchant item, and updates the merchant item show page' do
      merchant = Merchant.create!(name: 'Yeti')

      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')

      visit "/merchants/#{merchant.id}/items/#{item_1.id}"
      click_link "Edit #{item_1.name}"

      fill_in 'name', with: 'flask'
      fill_in 'unit_price', with: '30'
      fill_in 'description', with: 'wine'
      click_button "Update Item"

      expect(current_path).to eq("/merchants/#{merchant.id}/items/#{item_1.id}")
      expect(page).to have_content('flask')
      expect(page).to have_content('30')
      expect(page).to have_content('wine')
      expect(page).to have_content("Success: The information has been successfully updated")
    end
  end
end
