require "rails_helper"

RSpec.describe "Merchant's dashboard", type: :feature do
  describe "as merchant" do
    before(:each) do
      @merchant = Merchant.create!(name: "Sam Devine")
      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it "see the name of my merchant" do
      expect(page).to have_content(@merchant.name)
    end
  end
end


# As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant
