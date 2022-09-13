require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
  describe 'As a merchant' do
    describe 'When I visit the merchant dashboard /merchants/merchant_id/dashboard' do

      it 'Then I see the name of my merchant' do
        @earring_city = Merchant.create!(name: "Earring City" )

        visit "/merchants/#{@earring_city.id}/dashboard"

        expect(page).to have_content('Earring City')
        expect(page).to_not have_content("Anne's Necklace Shoppe")
      end

    end
  end
end