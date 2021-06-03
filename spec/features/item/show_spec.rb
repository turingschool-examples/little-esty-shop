require 'rails_helper'

RSpec.describe 'items show page'do
  before :each do
    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant_1.id)

    @merchant_2 = Merchant.create!(name: 'BreadNButter')
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant_2.id)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant_2.id)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant_2.id)
  end

  describe 'item attributes' do
    it 'can display only that items attributes' do
      visit "/merchants/#{@merchant_2.id}/items/#{@item_4.id}"

      expect(page).to have_content("#{@item_4.name}")
      expect(page).to have_content("#{@item_4.description}")
      expect(page).to have_content("#{@item_4.unit_price}")

      expect(page).to_not have_content("#{@item_5.name}")
      expect(page).to_not have_content("#{@item_5.description}")
      expect(page).to_not have_content("#{@item_5.unit_price}")
    end
  end
end
