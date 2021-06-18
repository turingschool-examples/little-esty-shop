require 'rails_helper'

describe 'Merchant Dashboard Page' do
  before(:each) do
    @merch = Merchant.create!(name:"Random Combination")

  end
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant
  it 'has the name of the merchant' do 
    visit "/merchants/#{@merch.id}/dashboard"
    expect(page).to have_content(@merch.name)
  end

  #   As a merchant,
  # When I visit my merchant dashboard
  # Then I see link to my merchant items index (/merchants/merchant_id/items)
  # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
  it 'has 2 links, to merchant items, and merchant invoices' do
    visit "/merchants/#{@merch.id}/dashboard"
    expect(page).to have_content("Items")
    expect(page).to have_content("Invoices")
  end

  #   As a merchant,
  # When I visit my merchant dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  it 'has the top 5 customers by number successful transactions' do

  end

  it 'shows number of successful transactions with merchant for the top 5 customers' do
  
  end
  #   As a merchant
  # When I visit my merchant dashboard
  # Then I see a section for "Items Ready to Ship"
  # In that section I see a list of the names of all of my items that
  # have been ordered and have not yet been shipped,
  # And next to each Item I see the id of the invoice that ordered my item
  # And each invoice id is a link to my merchant's invoice show page
  it 'has a section for items ready to ship, with list of names of items to ship' do

  end

  it 'each item has the id of the invoice, which is a link to the invoice show page' do

  end
  # As a merchant
  # When I visit my merchant dashboard
  # In the section for "Items Ready to Ship",
  # Next to each Item name I see the date that the invoice was created
  # And I see the date formatted like "Monday, July 18, 2019"
  # And I see that the list is ordered from oldest to newest  

  it 'has the date of the invoice formatted, list ordered from oldest to newest' do

  end
end