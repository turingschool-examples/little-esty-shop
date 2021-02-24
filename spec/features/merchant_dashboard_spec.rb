require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  describe "When I visit my merchant dashboard (/merchant/merchant_id/dashboard)" do
    it "can see the name of my merchant"do
     merchant = Merchant.create(name: "John's Jewelry")

     visit "/merchant/#{merchant.id}/dashboard"

      expect(page).to have_content("John's Jewelry")
    end
  end
end
