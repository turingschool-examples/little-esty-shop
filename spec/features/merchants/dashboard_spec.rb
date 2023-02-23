require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  let!(:merchant) { Merchant.create!(name: "Trader Bob's") }
  describe "User story 1" do
    it "As a merchant, when I visit my merchant dashboard 
      (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do
      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content("Trader Bob's")
    end
  end
end