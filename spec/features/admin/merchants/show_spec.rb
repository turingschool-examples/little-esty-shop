require 'rails_helper'

RSpec.describe '#show' do
  before :each do
    @merchant1 = Merchant.create!(name: "Carlos Jenkins") 
    visit "/admin/merchants/#{@merchant1.id}"
  end

  describe 'as an admin when I visit the admin merchants show page' do
    it 'I see the name of that merchant' do

      expect(page).to have_content("Carlos Jenkins")

    end

    it 'I see a link to update the merchant' do
      click_link "Update Merchant"
      expect(current_path).to eq(edit_merchant_path(@merchant1))

      expect(page).to have_content("Carlos Jenkins")
      fill_in "Name", with: "Updated Merchant Name"
      click_button "Update Merchant"
      
      expect(current_path).to eq(admin_merchant_path(@merchant1))
      expect(page).to have_content("Merchant was successfully updated.")
      expect(page).to have_content("Updated Merchant Name")
    end

    it 'If I delete the name and enter without any data I remain on the update page with a flash message' do
      click_link "Update Merchant"
      expect(current_path).to eq(edit_merchant_path(@merchant1))

      expect(page).to have_content("Carlos Jenkins")
      fill_in "Name", with: ""
      click_button "Update Merchant"
      
      expect(current_path).to eq(edit_merchant_path(@merchant1))
      expect(page).to have_content("Merchant not updated: Name can't be blank")
    end

  end
  
end