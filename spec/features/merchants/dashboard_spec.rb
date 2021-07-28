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
  end
end
