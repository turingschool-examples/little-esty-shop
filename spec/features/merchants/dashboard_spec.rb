require 'rails_helper'

RSpec.describe 'merchant dashboard' do
    it "When I visit a merchant dashboard I see the name of my merchant" do
      merchant = create(:merchant, name: 'Bob')

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content('Bob')
    end
end
