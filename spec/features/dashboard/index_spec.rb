require 'rails_helper'
# Merchant Dashboard

# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
RSpec.describe 'merchant dashboard show page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  describe 'visit merchant dashboard' do
    it 'shows the name of my merchant' do
      visit "/merchants/#{nomi.id}/dashboard"
      # merchant_dashboard_index_path

      expect(page).to have_content(nomi.name)
    end
  end
end