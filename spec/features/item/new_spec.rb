require 'rails_helper'

RSpec.describe 'items show page'do
  before :each do
    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @merchant_2 = Merchant.create!(name: 'BreadNButter')
  end

  describe 'form' do
    it 'has a form to fill out new information for an item' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      expect(find('form')).to have_content("Name")
      expect(find('form')).to have_content("Description")
      expect(find('form')).to have_content("Unit price")
      expect(page).to have_button("Create Item")
    end

    it 'creates a new item' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      fill_in "Name", with: "T-Rex Floatie"
      fill_in "Description", with: "Floats for hours!"
      fill_in "Unit price", with: 125.25
      select "disable"
      click_button "Create Item"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

      expect(page).to have_content("T-Rex Floatie")
      # expect(page).to have_button("Enable")
      expect(page).to_not have_content("BreadNButter")
    end
  end
end
