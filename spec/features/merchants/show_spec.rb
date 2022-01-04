require 'rails_helper'

RSpec.describe "Merchant Dashboad Show Page" do
#   Merchant Dashboard
#
# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
  it 'shows merchant name' do
    merch_1 = Merchant.create!(name: "Shop Here")

    visit "/merchants/#{merch_1.id}/dashboard"

    within ".merchant" do
      expect(page).to have_content("Merchant Name: #{merch_1.name}")
    end
  end
end
