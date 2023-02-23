require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")
    visit "/merchants/#{@merchant.id}/dashboard"
  end

  describe "User story 1" do
    it "As a merchant, when I visit my merchant dashboard 
      (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do

      expect(page).to have_content("Trader Bob's")
    end
  end

  describe "User story 2" do
    describe "When I visit my merchant dashboard" do
      it "shows a link to my merchant items index (/merchants/merchant_id/items)" do
        save_and_open_page
        expect(page).to have_link("Items", href: "/items")
      end

      xit "show a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        expect(page).to have_link("Invoices", href: "/invoices")
      end
    end
  end
end