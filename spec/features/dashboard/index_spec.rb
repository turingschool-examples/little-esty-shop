require 'rails_helper'
# Merchant Dashboard Links

# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
RSpec.describe 'merchant dashboard show page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  describe 'visit merchant dashboard' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(nomi)

      expect(page).to have_content(nomi.name)
    end

    it 'has a link to merchant items index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Items") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/items")
    end

    # it 'has a link to my merchant invoices index' do
    #   visit merchant_dashboard_index_path(nomi)

    #   click_on("My Invoices") 
      
    #   expect(page).to have_current_path("/merchants/#{nomi.id}/invoices")
    # end
  end
end