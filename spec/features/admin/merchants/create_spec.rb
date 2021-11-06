require 'rails_helper'

RSpec.describe "admin merchants create" do
  describe 'the admin merchants new' do
    it 'renders the new form' do
      visit admin_merchants_path

      expect(page).to have_content('Add Merchant')
      click_link "Add Merchant"
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  describe 'admin merchants create' do
    it 'creates a new merchant' do
      visit new_admin_merchant_path
      fill_in "Name", with: "Paws and Claws"
      click_button "Submit"

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("Paws and Claws")
    end
  end
end
