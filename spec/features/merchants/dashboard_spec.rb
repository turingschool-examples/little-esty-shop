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

    it "see link to merchant items index" do
      click_link "Merchant's Items Index"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it "see a link to merchant invoice index" do
      click_link "Merchant's Invoices Index"
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end
  end
end
