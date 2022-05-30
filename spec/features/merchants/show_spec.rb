require "rails_helper"

RSpec.describe "Merchants show page" do
  describe "Merchant Dashboard" do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it "has the merchant's name" do
      merchant = create(:merchant)
      visit "/merchants/#{merchant.id}/dashboard"

      # save_and_open_page # does not include CSS

      expect(page).to have_content(merchant.name)
    end
  end
end
