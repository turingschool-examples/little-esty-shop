require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
  # Then I see the name of my merchant
  
  before :each do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Rempel and Jones')
    @merchant_3 = Merchant.create!(name: 'Willms and Sons')
  end

  describe 'User story 1' do
    it 'can show the merchant name' do
      visit "/merchants/#{@merchant_1.id}/dashboard"
      
      expect(page).to have_content(@merchant_1.name)
    end
  end
end