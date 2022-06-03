require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  it "displays the name of each merchant in the system" do
    merchant1 = Merchant.create!(name: "REI")
    merchant2 = Merchant.create!(name: "Target")
    merchant3 = Merchant.create!(name: "Walgreens")

    visit admin_merchants_path

    expect(page).to have_content("Admin Merchants Index")

    within ".disabled-merchants" do
      expect(page).to have_content("REI")
      expect(page).to have_content("Target")
      expect(page).to have_content("Walgreens")
      expect(page).to_not have_content("Hot Topic")
    end
  end
end
