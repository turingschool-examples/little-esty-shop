require 'rails_helper'

RSpec.describe 'Admin Merchants New' do
  describe 'user story #12' do
    it 'new merchant link adds new merchant' do

      visit "/admin/merchants"
      click_link "New Merchant"

      expect(current_path).to eq("/admin/merchants/new")

      fill_in 'Name', with: "Bumblebee Honey Co"
      click_button 'Submit'

      expect(current_path).to eq("/admin/merchants")

      within("#disabled") do
        expect(page).to have_content("Bumblebee Honey Co")
      end
    end
  end
end
