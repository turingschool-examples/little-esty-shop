require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe 'as a merchant' do
    let!(:merchant_1) { Merchant.create!(name: "Johns Tools") }
    let!(:merchant_2) { Merchant.create!(name: "Hannas Hammocks") }
    describe 'When I visit my merchant dashboard' do
      it 'then I see the name of the merchant' do

        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)
      end
    end
  end
end
