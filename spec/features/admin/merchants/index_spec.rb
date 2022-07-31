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

  it 'when user clicks on name of merchant, takes user to that merchant\'s admint show page, and shows the name of that merchant' do
    merchant1 = Merchant.create!(name: "Trader Joes")
    merchant2 = Merchant.create!(name: "Whole Foods")
    merchant3 = Merchant.create!(name: "Yes Market")
    merchant4 = Merchant.create!(name: "Pasta Emporium")

    visit admin_merchants_path

    within "#merchant-#{merchant1.id}" do
      click_link "Trader Joes"
    end

    expect(current_path).to eq(admin_merchant_path(merchant1.id))

    expect(page).to have_content("Trader Joes")
  end
end

# Admin Merchant Show

# As an admin,
# When I click on the name of a merchant from the admin merchants index page,
# Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
# And I see the name of that merchant