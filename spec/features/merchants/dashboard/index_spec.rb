require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @merchant = create(:merchant)
  end
  # let!(:merchant) { Merchant.create!(name: "Trader Bob's") }
  describe "User story 1" do
    it "As a merchant, when I visit my merchant dashboard 
      (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do
      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content("Trader Bob's")
    end
  end

  xdescribe "User story 2" do
    describe "When I visit my merchant dashboard" do
      it "shows a link to my merchant items index (/merchants/merchant_id/items)" do
        visit "/merchants/#{merchant.id}/dashboard"
        expect(page).to have_link("Items", href: "/items")
        expect(page).to have_link("Merchants", href: "/merchants")
      end

      it "show a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        
      end
    end
  end
end