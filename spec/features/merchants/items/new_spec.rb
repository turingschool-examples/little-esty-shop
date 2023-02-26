require 'rails_helper'

RSpec.describe "Merchant_Items#New", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    visit "/merchants/#{@merchant.id}/items/new"
  end

  describe "User Story 11" do
    it "I see a form that allows me to add item information" do

      expect(page).to have_content("Add a New Item")
      expect(find('form')).to have_content("Name")
      expect(find('form')).to have_content("Description")
      expect(find('form')).to have_content("Unit price")
    end

    it "When I fill out the form I click Submit then I am taken back to the items index page" do
  
      fill_in "Name", with: "Super Mario"
      fill_in "Description", with: "It's a video game!"
      fill_in "Unit price", with: 40
      click_button "Create Item"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end
  end
end