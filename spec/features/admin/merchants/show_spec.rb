require 'rails_helper'

RSpec.describe 'Admin Merchants Show', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe "Admin Merchant Update (User Story 26)" do
    it "displays a link to update merchant information" do
      visit admin_merchant_path(@merchant_1)
      expect(page).to have_link("Update Merchant Information")
      visit admin_merchant_path(@merchant_2)
      expect(page).to have_link("Update Merchant Information")
    end

    it "clicking redirects me to a prefilled form to update merchant information" do
      visit admin_merchant_path(@merchant_1)
      click_link("Update Merchant Information")
      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
      expect(page).to have_content("Edit #{@merchant_1.name}")
      expect(page).to have_field('merchant_name')
      expect(page).to have_button("Update Merchant")

      visit admin_merchant_path(@merchant_2)
      click_link("Update Merchant Information")
      expect(current_path).to eq(edit_admin_merchant_path(@merchant_2))
      expect(page).to have_content("Edit #{@merchant_2.name}")
      expect(page).to have_field('merchant_name')
      expect(page).to have_button("Update Merchant")
    end

    it "clicking submit updates information,redirects to admin merchant show page, and displays a flash message" do
      visit edit_admin_merchant_path(@merchant_1)
      expect(page).to have_content("Edit #{@merchant_1.name}")
      fill_in 'merchant_name', with: "New Name"
      click_button("Update Merchant")
      expect(page).to have_current_path(admin_merchant_path(@merchant_1))
      expect(page).to have_content("Information has been successfully updated")
      expect(page).to have_content("Merchant Name: New Name")
    end

    it "cannot update merchant information with an empty name field" do
      visit edit_admin_merchant_path(@merchant_2)
      expect(page).to have_content("Edit #{@merchant_2.name}")
      fill_in 'merchant_name', with: ""
      click_button("Update Merchant")
      expect(page).to have_current_path(edit_admin_merchant_path(@merchant_2))
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end