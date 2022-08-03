require 'rails_helper'

RSpec.describe 'admin merchant new page' do

  describe 'features' do

    it 'has form for entering new merchant information, and when "submit" is clicked, return to admin/merchant/index and see new merchant with status of disabled' do
      
      visit new_admin_merchant_path

      fill_in "Merchant Name", with: "Chips R Us"

      click_on "Submit"

      expect(current_path).to eq(admin_merchants_path)

      expect(page).to have_content("Chips R Us created!")

      within "#disabled-merchants" do
        expect(page).to have_content("Chips R Us")
      end
    end

    it 'rejects input and redirects back to new page if field left empty' do
      visit new_admin_merchant_path

      click_on "Submit"

      expect(current_path).to eq(new_admin_merchant_path)
      
      expect(page).to have_content("Error, please complete all fields")
    end

  end
end