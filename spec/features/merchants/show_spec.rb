# 1. Merchant Dashboard

# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard Page', type: :feature do
  let!(:merchant1) {Merchant.create!(name:'Steve')}
  let!(:merchant2) {Merchant.create!(name:'Fred')}

  describe "As a merchant visiting '/merchants/:id/dashboard'" do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_content('Steve')
    end
    
    it 'has a link to merchant items index' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_link('My Items')
      click_link("My Items")
      expect(current_path).to eq(merchant_items_path(merchant1))
    end
    
    it 'has a link to merchant invoice index' do
      visit merchant_dashboard_path(merchant1)
      
      expect(page).to have_link('My Invoices')
      click_link("My Invoices")
      expect(current_path).to eq(merchant_invoices_path(merchant1))
    end
  end
end

