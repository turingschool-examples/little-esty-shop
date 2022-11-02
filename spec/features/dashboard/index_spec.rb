require 'rails_helper'

RSpec.describe 'merchant dashboard show page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}
  let!(:timmy) {Customer.create!(first_name: "Timmy", last_name: "Limmy")}
  let!(:invoice_1) {timmy.invoices.create!(status: 0)}
  
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

    it 'has a link to my merchant invoices index' do
      visit merchant_dashboard_index_path(nomi)

      click_on("My Invoices") 
      
      expect(page).to have_current_path("/merchants/#{nomi.id}/invoices")
    end
  end
end