require 'rails_helper'

RSpec.describe "admin/merchant edit page", type: :feature do
  describe "edit" do
    before do
      test_data
      stub_request(:get, "https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
        .to_return(status: 200, body: File.read('./spec/fixtures/merchant.json'))
      stub_request(:get, "https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
        .to_return(status: 200, body: File.read('./spec/fixtures/app_logo.json'))
    end

    it "edit page" do
      visit edit_admin_merchant_path(@merchant_3)

      expect(page).to have_no_content("This is the name now")

      expect(page).to have_field("Name", with: @merchant_3.name)
      
      fill_in "Name", with: "This is the name now"
      click_button("Update Merchant")

      expect(current_path).to eq(admin_merchant_path(@merchant_3))

      expect(page).to have_content("This Merchant's information has been updated")
      expect(page).to have_content("This is the name now")
    end
  end
end