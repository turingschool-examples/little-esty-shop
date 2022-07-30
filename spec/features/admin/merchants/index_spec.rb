require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it 'displays the names of each merchant in the system' do
    merchant1 = Merchant.create!(name: "Trader Joes")
    merchant2 = Merchant.create!(name: "Whole Foods")
    merchant3 = Merchant.create!(name: "Yes Market")
    merchant4 = Merchant.create!(name: "Pasta Emporium")

    visit admin_merchants_path

    within "#merchant-list" do
      expect(page).to have_content("Trader Joes")
      expect(page).to have_content("Whole Foods")
      expect(page).to have_content("Yes Market")
      expect(page).to have_content("Pasta Emporium")
    end
  end
end