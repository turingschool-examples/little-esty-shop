require 'rails_helper'

RSpec.describe "merchant dashboard" do
  it 'tests factorybot' do
    merchant = create(:merchant)
  end

  it 'can show name of merchant' do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"
    expect(page).to have_content(merchant.name)
  end

  it 'can link to merchant items index' do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/dashboard"
    click_link("My Items")
    expect(current_path).to eq("/merchants/#{merchant.id}/items")

    # visit "/merchants/#{merchant.id}/dashboard"
    # click_link("My Invoices")
    # expect(current_path).to eq("/merchants/#{merchant.id}/invoices")

  end
end


# Merchant Dashboard Links
#
# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
