require 'rails_helper'

RSpec.describe 'items show page'do
  before :each do
    @merchant1 = Merchant.create!(name: 'LittleHomeSlice')
    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant1.id)

    @merchant2 = Merchant.create!(name: 'BreadNButter')
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.2, merchant_id: @merchant2.id)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.3, merchant_id: @merchant2.id)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.4, merchant_id: @merchant2.id)
  end

  describe 'item attributes' do
    it 'can display only that items attributes' do
      visit "/merchants/#{@merchant2.id}/items/#{@item4.id}"

      expect(page).to have_content("#{@item4.name}")
      expect(page).to have_content("#{@item4.description}")
      expect(page).to have_content("#{@item4.unit_price}")

      expect(page).to_not have_content("#{@item5.name}")
      expect(page).to_not have_content("#{@item5.description}")
      expect(page).to_not have_content("#{@item5.unit_price}")
    end
  end

  describe 'update link' do
    it 'has a link to update the item' do
      visit "/merchants/#{@merchant2.id}/items/#{@item5.id}"

      expect(page).to have_button('Update')

      click_button('Update')

      expect(current_path).to eq("/merchants/#{@merchant2.id}/items/#{@item5.id}/edit")
    end

    it 'can show the updated information from the edit page' do
      visit "/merchants/#{@merchant2.id}/items/#{@item5.id}/edit"

      fill_in "Name", with: "The Best Thing"
      fill_in "Description", with: "It is so amazing, really."
      fill_in "Unit price", with: 150.5
      click_button "Submit Item Update"

      expect(current_path).to eq("/merchants/#{@merchant2.id}/items/#{@item5.id}")
      expect(page).to have_content("The Best Thing")
      expect(page).to have_content("It is so amazing, really.")
      expect(page).to have_content(150.50)

      expect(page).to_not have_content("Thing 5")
      expect(page).to_not have_content("This is the fifth thing.")
      expect(page).to_not have_content(15.30)
    end
  end
end
