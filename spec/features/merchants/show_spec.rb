require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')
  end
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant
  describe 'User story 1' do
    it 'can show the merchant name' do
      visit merchant_path(@merchant_1)
      
      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'User Story 2' do 
    it 'displays a link to merchant items index and merchant invoices index' do 
      visit merchant_path(@merchant_1)

      expect(page).to have_link("My Items")
      expect(page).to have_link("My Invoices")
      
      click_on "My Items"
      
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")      
      
      visit merchant_path(@merchant_1)
      
      click_on "My Invoices"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")      
    end
  end
end