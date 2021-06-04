require 'rails_helper'

RSpec.describe 'items index page' do
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

  describe 'item names' do
    it 'can list the names of all the items for that merchant' do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)

      expect(page).to_not have_content(@item_4.name)
      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
    end

    it 'has the item names listed as links' do
      visit "/merchants/#{@merchant_2.id}/items"

      expect(page).to have_link(@item_4.name)

      click_link "#{@item_4.name}"

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}")
    end
  end

  describe 'create' do
    it 'has a link to create a new item' do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_button("Create New Item")
    end

    it 'takes the user to the new page' do
      visit "/merchants/#{@merchant_2.id}/items"

      click_button "Create New Item"

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/new")
    end
  end
end
