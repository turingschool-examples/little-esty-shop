# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
require 'rails_helper'

RSpec.describe "The Merchant Dashboard" do
  it 'Contains the name of the merchant' do
    merchant = Merchant.create!(name: 'Bobby')

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end

  it 'contains a link to merchant item index and merchant invoices index' do
    merchant = Merchant.create!(name: 'Bobby')

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link("My Items", href: "/merchants/#{merchant.id}/items")
    expect(page).to have_link("My Invoices", href: "/merchants/#{merchant.id}/invoices")
  end

  it 'contains a list of the top five customers based on successful transactions' do
    visit "/merchants/2/dashboard"
    # save_and_open_page
    expect(page).to have_content("Favorite Customers\nIlene Pfannerstill - 9 Purchases Ramona Reynolds - 8 Purchases Joey Ondricka - 7 Purchases Mariah Toy - 3 Purchases Logan Kris - 3 Purchases")

  end
end