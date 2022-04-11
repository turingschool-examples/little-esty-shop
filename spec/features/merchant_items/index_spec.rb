require 'rails_helper'

RSpec.describe 'merchant items index page' do
  describe 'list of item names for merchant' do
    it 'lists items for merchant' do
      merchant = Merchant.create!(name: 'Yeti')
      merchant_2 = Merchant.create!(name: 'Hydroflask')
      item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
      item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
      item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
      item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')

      visit "/merchants/#{merchant.id}/items"
      expect(page).to have_content("#{item_1.name}")
      expect(page).to have_content("#{item_2.name}")
      expect(page).to have_content("#{item_3.name}")
      expect(page).to_not have_content("#{item_4.name}")
    end
  end
end
