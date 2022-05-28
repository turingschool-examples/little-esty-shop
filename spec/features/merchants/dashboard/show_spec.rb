require 'rails_helper'

RSpec.describe 'merchant dashboard show' do

  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }
  let!(:merchant3) { Merchant.create!(name: "Willms and Sons") }
  let!(:merchant4) { Merchant.create!(name: "Cummings-Thiel") }
  let!(:merchant5) { Merchant.create!(name: "Williamson Group") }
  let!(:merchant6) { Merchant.create!(name: "Bernhard-Johns") }

  it "displays a merchant's name" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
  end

  it "displays links to a merchant's items and invoices index pages" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Items Index")
    expect(page).to have_content("Invoices Index")
  end

  # Merchant Dashboard Statistics - Favorite Customers
  # As a merchant,
  # When I visit my merchant dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  it "displays the largest number of successful transactions with top 5 customers" do
    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content("Top 5 Favorite Customers: ")

    within "#customer-#{customer1.id}" do
      expect(page).to have_content(customer1.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer2.id}" do
      expect(page).to have_content(customer2.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer3.id}" do
      expect(page).to have_content(customer3.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer4.id}" do
      expect(page).to have_content(customer4.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end

    within "#customer-#{customer5.id}" do
      expect(page).to have_content(customer5.name)
      expect(page).to have_content("Number of Successful Transactions: ")
    end
  end
end
