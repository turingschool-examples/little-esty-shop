require 'rails_helper'

RSpec.describe '' do
  before(:each) do
    visit new_admin_merchant_path
  end
  describe 'create merchant form' do
  context 'when valid information entered' do
    it 'allows admin to make a new merchant' do
      fill_in 'Name', with: "Kelli's Beads"
      click_button "Submit"
      
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content "Merchant has been successfully created"

      expect(page).to have_content "Kelli's Beads"
    end
  end

  context 'when no information entered' do
    it 'provides error message and redirects to form' do
      click_button "Submit"
      
      expect(current_path).to eq("/admin/merchants/new")
      expect(page).to have_content "Failed to create merchant"
    end
  end
end
end