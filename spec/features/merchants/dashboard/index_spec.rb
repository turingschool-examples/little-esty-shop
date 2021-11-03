# As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant

require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  it "shows the name of my merchant" do
    merchant1 = Merchant.create!(name: "Larry's Lucky Ladles")

    visit merchant_dashboard_index_path(merchant1)

    expect(page).to have_content(merchant1.name)
  end
end