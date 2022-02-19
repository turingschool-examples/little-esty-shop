require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  describe '#user story #34' do
    it 'displays the item attributes' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      visit "/merchants/#{merchant1.id}/items"

      click_on item1.name
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.unit_price)
    end
  end

  describe '#user story 33' do
    it 'allows the merchant to update their items' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      visit "/merchants/#{merchant1.id}/items/#{item1.id}"
      expect(page).to have_link("Update #{item1.name}")
      click_on("Update #{item1.name}")
      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")
      expect(page).to have_field(item_name: 'Monkey Paw')
      expect(page).to have_field(item_description: 'A furry mystery')
      expect(page).to have_field(item_unit_price: 3)

      within('#item_update') do
        fill_in 'item_unit_price', with: 23
        click_on 'Update Item'
      end
      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
      expect(page).to have_content('Item Successfully Updated')
    end
  end
end
