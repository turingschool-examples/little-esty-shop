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

      it "merchant dashboard displays top 5 customers with most succesful transactions" do
        # As a merchant,
        # When I visit my merchant dashboard
        # Then I see the names of the top 5 customers

        # who have conducted the largest number of successful transactions with my merchant
        # And next to each customer name I see the number of successful transactions they have
        # conducted with my merchant
      end

    end
  end
end
