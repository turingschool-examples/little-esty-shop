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

  it 'has a list of items ready to ship' do
    visit "/merchants/1/dashboard"

    expect(page).to have_content("Items Ready to Ship")
    expect(page).to have_content("Item Qui Esse - Invoice #1 Item Ea Voluptatum - Invoice #1 Item Nemo Facere - Invoice #1 Item Provident At - Invoice #1 Item Quidem Suscipit - Invoice #2 Item Rerum Est - Invoice #3 Item Autem Minima - Invoice #38 Item Ea Voluptatum - Invoice #38 Item Et Cumque - Invoice #40 Item Voluptatem Sint - Invoice #40 Item Ea Voluptatum - Invoice #75 Item Nemo Facere - Invoice #75 Item Expedita Aliquam - Invoice #75 Item Expedita Fuga - Invoice #75 Item Quo Magnam - Invoice #75 Item Quidem Suscipit - Invoice #76")
  end
end