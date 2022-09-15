require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'US8' do
    it 'show an update button that takes you to the edit page' do
      merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
      merchant_3 = Merchant.create!(name: "Sheena Yeaston")
      # As an admin,
      # When I visit a merchant's admin show page
      visit "/admin/merchants/#{merchant_2.id}"
      # Then I see a link to update the merchant's information.
      click_link "Update Merchant Info"
      # When I click the link
      # Then I am taken to a page to edit this merchant
      expect(current_path).to eq("/admin/merchants/#{merchant_2.id}/edit")
    end
    # And I see a form filled in with the existing merchant attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the merchant's admin show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
  end
end