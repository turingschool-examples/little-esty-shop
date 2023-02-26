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

    it 'I see a link ot update the merchant' do
      click_link "Update Merchant"
      expect(current_path).to eq(edit_merchant_path(@merchant1))

      expect(page).to have_content("Carlos Jenkins")
      fill_in "Name", with: "Updated Merchant Name"
      click_button "Update Merchant"
      
      save_and_open_page
      expect(current_path).to eq(admin_merchant_path(@merchant1))
      expect(page).to have_content("Merchant was successfully updated.")
      expect(page).to have_content("Updated Merchant Name")
    end

  end
  
end