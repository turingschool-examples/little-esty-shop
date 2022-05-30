require 'rails_helper'

RSpec.describe 'Merchants show page', type: :feature do
  let!(:merchant) { create(:merchant) }
  describe 'Merchant Dashboard' do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant
    it "has the merchant's name" do
      visit "/merchants/#{merchant.id}/dashboard"

      # save_and_open_page # does not include CSS

      expect(page).to have_content(merchant.name)
    end
  end

  describe 'Dashboard Links' do
    it 'links to merchant items and merchant invoices' do
      visit "/merchants/#{merchant.id}/dashboard"

      click_link 'Merchant Items'
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
    end
  end
end
