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
end