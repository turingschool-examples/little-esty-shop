require 'rails_helper'

RSpec.describe "admin/merchants/new" do
  describe "display" do
    before do
      test_data
    end

    it "has the appropriate fields and buttons" do
      visit new_admin_merchant_path

      expect(page).to have_content "Enter information for new merchant"

      expect(page).to have_field("Name")
      expect(page).to have_button("Create Merchant")
    end

    it "creates new merchant" do
      visit new_admin_merchant_path

      expect(page).to have_no_content("Bobbo's crab joint")
      fill_in("Name", with: "Bobbo's crab joint")
      click_button("Create Merchant")
      expect(current_path).to eq(admin_merchants_path)
      visit admin_merchants_path
   
      within "#disabled_merchants" do
        expect(page).to have_content("Bobbo's crab joint")
      end
    end
  end
end