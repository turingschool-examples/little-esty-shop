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

  describe 'edit form' do
    it 'shows a form with the existing attribute information filled in' do
      visit "/merchants/#{@merchant_2.id}/items/#{@item_5.id}/edit"

      expect(page).to have_content("#{@item_5.name}")
      expect(find('form')).to have_content("Name")
      expect(find('form')).to have_content("Description")
      expect(find('form')).to have_content("Unit price")
      expect(page).to have_button("Submit Item Update")
    end

    it 'only shows one items attribute information filled in' do
      visit "/merchants/#{@merchant_2.id}/items/#{@item_5.id}/edit"

      expect(page).to_not have_content("#{@item_1.name}")
    end

    it 'can update the items attributes and redirect to the show page' do
      visit "/merchants/#{@merchant_2.id}/items/#{@item_5.id}/edit"

      fill_in "Name", with: "The Best Thing"
      fill_in "Description", with: "It is so amazing, really."
      fill_in "Unit price", with: 150.5
      click_button "Submit Item Update"

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_5.id}")
    end

    it 'gives an error message if all fields are not filled out' do
      visit "/merchants/#{@merchant_2.id}/items/#{@item_5.id}/edit"

      fill_in "Name", with: "The Best Thing"
      fill_in "Description", with: nil
      fill_in "Unit price", with: 150.5
      click_button "Submit Item Update"

      expect(page).to have_content("Error: #{@item_5.errors.full_messages.to_sentence}")
      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_5.id}/edit")
    end
  end
end
