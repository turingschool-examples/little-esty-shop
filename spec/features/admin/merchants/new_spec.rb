require "rails_helper"

RSpec.describe "Admin Merchant New Page" do

  it "can create a new merchant", :vcr do
    visit new_admin_merchant_path
    fill_in "Name:", with: "Test123"
    click_button "Save"
    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Test123")
  end

end
