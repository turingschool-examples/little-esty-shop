# spec/features/merchants/dashboard_spec

require 'rails_helper'

RSpec.describe 'merchants dashboard show page' do 

  # As a merchant,
  # When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
  # Then I see the name of my merchant

  describe 'display' do
    before :each do 
      @merchant = Merchant.create!(name: 'Sally Handmade')
    end

    it 'shows name of merchant' do
      visit "merchants/#{@merchant.id}/dashboard"
      
      expect(page).to have_content('Sally Handmade')
    end
  end
end