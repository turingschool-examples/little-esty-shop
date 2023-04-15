require 'rails_helper'

RSpec.describe "admin/merchant edit page", type: :feature do
  describe "edit" do
    before do
      test_data
    end

    it "edit page exists" do
      visit edit_admin_merchant_path(@merchant_3)

      expect(page).to have_no_content("This is the name now")

      expect(page).to have_field("Name", with: @merchant_3.name)
      
      fill_in "Name", with: "This is the name now"
      click_button("Update Merchant")

      expect(current_path).to eq(admin_merchant_path(@merchant_3))

      visit admin_merchant_path(@merchant_3)

      expect(page).to have_content("This is the name now")
    end
  end
end