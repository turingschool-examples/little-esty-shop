require 'rails_helper'

RSpec.describe 'Admin Merchant Create' do
  describe 'part 2 of US11' do
    it 'admin merchant create' do

      visit "/admin/merchants/new"
      # When I fill out the form I click ‘Submit’
      fill_in "Name", with: "No Pain No Grain"
      click_button "Submit"
      # Then I am taken back to the admin merchants index page
      expect(current_path).to eq("/admin/merchants")
      # And I see the merchant I just created displayed
      within '.disabled' do
        expect(page).to have_content("No Pain No Grain")
        # And I see my merchant was created with a default status of disabled.
      end
      within '.enabled' do
        expect(page).to_not have_content("No Pain No Grain")
      end
    end
  end
end
