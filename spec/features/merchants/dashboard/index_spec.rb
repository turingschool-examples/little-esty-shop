require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe "I visit a merchant dashboard" do

    it 'displays the merchant name' do
      merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      visit merchant_dashboard_index_path(merchant)
      expect(page).to have_content(merchant.name)
    end

    xit 'as a merchant it displays a link to the my merchant index items page' do
      merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)

      visit merchant_dashboard_index_path(merchant)

      expect(page).to have_link("Items Index")
      click_link("My Items Index")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/items")

      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_link("My Invoices Index")
      click_link("My Invoices Index")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/invoices")
    end
  end
end
