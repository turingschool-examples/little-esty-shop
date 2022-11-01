require 'rails_helper'

RSpec.describe 'On the Merchant Dashboard Index Page' do
  describe 'When I visit /merchants/:merchant_id/dashboard' do
# As a merchant,
# When I visit my merchant dashboard
# Then I see link to my merchant items index (/merchants/merchant_id/items)
# And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Dave")
      visit "/merchants/#{@merchant_1.id}/dashboard"
    end
    describe 'Then I see' do
      it 'the name of the merchant' do
        within "#attributes-merchant-#{@merchant_1.id}" do
          expect(page).to have_content(@merchant_1.name)
        end
      end

      it 'a link to merchant items index /merchants/:merchant_id/items' do
        within "#links-merchant-#{@merchant_1.id}" do
          expect(page).to have_link("#{@merchant_1.name} Items")
          click_link("#{@merchant_1.name} Items")
          expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
        end
      end

      it 'a link to merchant invoices index /merchants/:merchant_id/invoices' do
        within "#links-merchant-#{@merchant_1.id}" do
          expect(page).to have_link("#{@merchant_1.name} Items")
          click_link("#{@merchant_1.name} Invoices")
          expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
        end
      end
    end
  end
end
