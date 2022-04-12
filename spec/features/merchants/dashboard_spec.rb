require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
   it 'shows the merchants name' do

        merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content(merchant_1.name)
  end
end
