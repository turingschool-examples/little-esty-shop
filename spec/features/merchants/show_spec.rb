require 'rails_helper'

RSpec.describe 'Merchants show page', type: :feature do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }
  describe 'Merchant Dashboard' do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it "has the merchant's name" do
      visit "/merchants/#{merchant1.id}/dashboard"

      # save_and_open_page # does not include CSS

      expect(page).to have_content(merchant1.name)
    end
  end

  describe 'Dashboard Links' do
    it 'links to merchant items and merchant invoices' do
      visit "/merchants/#{merchant1.id}/dashboard"
      click_link 'My Items'
      expect(current_path).to eq("/merchants/#{merchant1.id}/items")

      visit "/merchants/#{merchant1.id}/dashboard"

      click_link 'My Invoices'
      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
    end
  end
end
