require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it "shows every merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    merchant_2 = Merchant.create!(name: 'Ted')

    visit admin_merchants_path

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end
  # As an admin,
  # When I visit the admin merchants index
  # I see a link to create a new merchant.
  # When I click on the link,

  it "has a link to create a new merchant that takes you to the new admin merchant page" do
    merchant = Merchant.create!(name: 'Weston')

    visit admin_merchants_path

    expect(page).to have_link('New Merchant')

    click_link 'New Merchant'

    expect(current_path).to eq(new_admin_merchant_path)
  end


end
