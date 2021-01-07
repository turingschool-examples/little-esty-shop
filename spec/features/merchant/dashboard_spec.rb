require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe 'As a merchant' do
    describe 'When I visit my merchant dashboard (/merchants/merchant_id/dashboard)' do
      before(:each) do
        @max = Merchant.create!(name: 'Merch Max')
      end

      it "Then I see the name of my merchant" do
        visit "/merchants/#{@max.id}/dashboard"

        expect(page).to have_content(@max.name)
      end

      it "Then I see links to my merchant items and invoices indexes (/merchants/merchant_id/items)" do
        visit "/merchants/#{@max.id}/dashboard"

        expect(page).to have_link('Items', href: "/merchants/#{@max.id}/items")
        expect(page).to have_link('Invoices', href: "/merchants/#{@max.id}/invoices")
      end
    end
  end
end
