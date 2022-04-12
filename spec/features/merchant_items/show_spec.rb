require 'rails_helper'

RSpec.describe 'merchant items show page' do
  describe 'list name, description and unit price of item' do
    it 'lists items details' do
      merchant = Merchant.create!(name: 'Yeti')

      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')

      visit "/merchants/#{merchant.id}/items/#{item_1.id}"
      expect(page).to have_content("#{item_1.name}")
      expect(page).to have_content("#{item_1.unit_price}")
      expect(page).to have_content("#{item_1.description}")
      expect(page).to_not have_content("#{item_2.name}")
    end
  end
end
