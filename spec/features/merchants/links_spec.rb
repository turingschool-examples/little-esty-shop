require "rails_helper"

RSpec.describe "Merchant Dashboard Links" do
  describe "When I visit my merchant dashboard" do
    it "Then I see link to my merchant items index (/merchant/merchant_id/items)" do
      merchant = Merchant.create(name: "John's Jewelry")

      visit "/merchant/#{merchant.id}/dashboard"

      within("#links") do
        expect(page).to have_link("My Items")

        click_on("My Items")

        expect(current_path).to eq("/merchant/#{merchant.id}/items")
      end
    end

    it "And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)" do
      merchant = Merchant.create(name: "John's Jewelry")

      visit "/merchant/#{merchant.id}/dashboard"

      within("#links") do
        expect(page).to have_link("My Invoices")

        click_on("My Invoices")

        expect(current_path).to eq("/merchant/#{merchant.id}/invoices")
      end
    end
  end
end
