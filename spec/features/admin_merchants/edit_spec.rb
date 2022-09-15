require 'rails_helper'

RSpec.describe 'Admin Merchants Edit page' do
  describe 'US8' do
    it 'edit form contains current murchent info' do
      merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
      merchant_3 = Merchant.create!(name: "Sheena Yeaston")
      # And I see a form filled in with the existing merchant attribute information
      visit "/admin/merchants/#{merchant_2.id}/edit"
      expect(page).to have_field("Merchant Name", with: 'Carrie Breadshaw')
      expect(page).to_not have_field("Merchant Name", with: 'Sheena Yeaston')
    end

    it 'can input new info for merchant and display a flash message for success' do
      merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
      merchant_3 = Merchant.create!(name: "Sheena Yeaston")
      # When I update the information in the form and I click ‘submit’
      visit "/admin/merchants/#{merchant_2.id}/edit"
      fill_in "Merchant Name",	with: "Carrie Loves Breadshaw"
      click_button "Submit"
      # Then I am redirected back to the merchant's admin show page where I see the updated information
      expect(current_path).to eq("/admin/merchants/#{merchant_2.id}")
      expect(page).to have_content("Carrie Loves Breadshaw")

      # And I see a flash message stating that the information has been successfully updated.
      # expect(page).to have_content("Update to Carrie Loves Breadshaw was successful!")
    end


  end
end