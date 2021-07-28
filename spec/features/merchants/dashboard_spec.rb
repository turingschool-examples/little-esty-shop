require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')
  end


  describe 'merchant' do
    it 'can display merchant name' do
      # Merchant Dashboard
      #
      # As a merchant,
      # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
      # Then I see the name of my merchant
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    it 'link to items' do
      # Merchant Dashboard Links
      # As a merchant,
      # When I visit my merchant dashboard
      # Then I see link to my merchant items index (/merchants/merchant_id/items)
      # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('My Items')

      click_on 'My Items'
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end

    it 'link to invoices' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('My Invoices')

      click_on 'My Invoices'
      save_and_open_page
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end
  end
end
