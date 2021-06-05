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

####Check work done here to ensure that it is correct, then move on to the
####to the index page showing the newly created item.
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.
