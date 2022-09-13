require 'rails_helper'

RSpec.describe 'Merchant dashboard' do
  describe 'as a merchant, when I visit the dashboard' do
    let(:merch_1) { Merchant.create!(name: "Bing Crosby")}
    let(:merch_2) { Merchant.create!(name: "Frank San")}
    it 'shows the name of the merchant' do
      merch_1 = Merchant.create!(name: "Bing Crosby")
      merch_2 = Merchant.create!(name: "Frank San")

      visit "/merchants/#{merch_1.id}/dashboard"

      within "#merchant_name" do
        expect(page).to have_content(merch_1.name)
        expect(page).to_not have_content(merch_2.name)
      end
    end

    
  end
end