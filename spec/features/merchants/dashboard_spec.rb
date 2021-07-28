require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')
    @merchant2 = Merchant.create!(name: 'BBs Petstore')
  end
  # Merchant Dashboard
  #
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant

  describe 'merchant' do
    it 'can display merchant name' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    it 'link to items' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(page).to have_content('My Items')

      click_on 'My Items'
      save_and_open_page
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end
  end
end
