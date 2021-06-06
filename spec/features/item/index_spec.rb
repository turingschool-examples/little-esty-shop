require 'rails_helper'

RSpec.describe 'items index page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant_1.id, status: 1)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant_1.id, status: 1)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant_1.id, status: 1)

    @merchant_2 = Merchant.create!(name: 'BreadNButter')
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant_2.id, status: 0)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant_2.id, status: 0)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant_2.id, status: 0)
    @item_7 = Item.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 116, merchant_id: @merchant_2.id, status: 0)
    @item_8 = Item.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.2, merchant_id: @merchant_2.id, status: 0)
    @item_9 = Item.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.7, merchant_id: @merchant_2.id, status: 0)
    @item_10 = Item.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.9, merchant_id: @merchant_2.id, status: 0)
  end

  describe 'item names' do
    it 'can list the names of all the items for that merchant' do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_link(@item_2.name)
      expect(page).to have_link(@item_3.name)

      expect(page).to_not have_link(@item_5.name)
      expect(page).to_not have_link(@item_6.name)
    end

    it 'has the item names listed as links' do
      visit "/merchants/#{@merchant_2.id}/items"

      within "#disabled-items-#{@item_4.id}" do
        expect(page).to have_link(@item_4.name)
        click_link "#{@item_4.name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}")
      end
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

  describe 'enable/disable' do
    it 'has a button to enable an item' do
      visit "/merchants/#{@merchant_2.id}/items"

      within "#disabled-items-#{@item_4.id}" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item_5.id}" do
        expect(page).to have_content(@item_5.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item_6.id}" do
        expect(page).to have_content(@item_6.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end
    end

    it 'has a button to disable an item' do
      visit "/merchants/#{@merchant_1.id}/items"

      within "#enabled-items-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end
    end
  end

  describe 'top 5 most popular items' do
    it 'can list the top 5 most popluar items' do
      visit "/merchants/#{@merchant_2.id}/items"

      expect(page).to have_content("Top Items")
    end
  end
end
