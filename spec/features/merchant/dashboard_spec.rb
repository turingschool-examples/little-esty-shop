require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/dashboard'" do
  before :each do
    @merchant1 = Merchant.create!(name: "Bob")
  end

  it "Shows the name of my merchant" do

    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_content(@merchant1.name)
  end
end


# As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant
