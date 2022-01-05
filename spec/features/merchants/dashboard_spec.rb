require 'rails_helper'

RSpec.describe 'merchant dashboard' do
    it "When I visit a merchant dashboard I see the name of my merchant" do
      merchant = create(:merchant, name: 'Bob')
      visit "/merchants/#{merchant.id}/dashboard"
      expect(page).to have_content('Bob')
    end

    it 'has a link to merchant invoices index' do
      merchant = create(:merchant_with_invoices, invoice_count: 3)
      visit "/merchants/#{merchant.id}/dashboard"
      click_link "Invoices"
      expect(current_path).to eq("/merchants/#{merchant.id}/invoices")
    end

    it 'has a link to merchant items index' do
      merchant = create(:merchant_with_items, invoice_count: 3)
      visit "/merchants/#{merchant.id}/dashboard"
      click_link "Items"
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
    end
end
