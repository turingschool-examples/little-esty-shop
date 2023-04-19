require 'rails_helper'

RSpec.describe "admin/merchants/new" do
  before (:each) do
    stub_request(:get, "https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
      .to_return(status: 200, body: File.read('./spec/fixtures/merchant.json'))
    stub_request(:get, "https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
      .to_return(status: 200, body: File.read('./spec/fixtures/app_logo.json'))
  end
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