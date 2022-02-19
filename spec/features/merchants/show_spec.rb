require 'rails_helper'
# As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant
RSpec.describe 'the merchant dashboard' do
  it 'has a dashboard page' do
    merchant = Merchant.create!(name: "Steve")
    visit "/merchant/#{merchant.id}/dashboard"
    expect(current_path).to eq("/merchant/#{merchant.id}/dashboard")
    expect(page).to have_content(merchant.name)
  end
  # As a merchant,
  # When I visit my merchant dashboard
  # Then I see link to my merchant items index (/merchant/merchant_id/items)
  # And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)
  it 'has links to the merchant items index' do
    merchant = Merchant.create!(name: "Steve")
    visit "/merchant/#{merchant.id}/dashboard"

    expect(page).to have_link("Item Index")
    expect(page).to have_link("Invoice Index")
  end
end
