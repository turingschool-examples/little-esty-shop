require 'rails_helper'

RSpec.describe "as a merchant" do
  describe "when I visit the merchant dashboard" do
    before(:each) do
      @merchant = Merchant.create!(name: "Buy more stuff")
    end
    it "Then I see the name of my merchant" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_content("#{@merchant.name}")
    end
    it "dashboard links to my merchant items index" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_link("Items Index")

      click_link("Items Index")

      expect(current_path).to eq(merchant_items_path(@merchant.id))
    end
    it "dashboard links to my merchant invoices index" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_link("Invoices Index")

      click_link("Invoices Index")

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end
    
  end
end
