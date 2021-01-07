require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe 'As a merchant' do
    describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)'
    it "Then I see the name of my merchant" do

      max = Merchant.create!(name: 'Merch Max')

      visit "/merchants/#{max.id}/dashboard"

      expect(page).to have_content(max.name)
    end
  end
end
