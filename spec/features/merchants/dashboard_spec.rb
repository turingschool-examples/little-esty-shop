require 'rails_helper'

RSpec.describe "merchant dashboard" do
  describe 'As a merchant, When I visit my merchant dashboard' do
    it 'I see the name of my merchant' do
      visit merchant_dashboards_path(Merchant.first)

      expect(page).to have_content(Merchant.first.name)
      expect(page).to_not have_content(Merchant.last.name)
    end

    it 'I see link to my merchant items index' do
      visit merchant_dashboards_path(Merchant.first)

      expect(page).to have_link("My Items")
    end

    it 'I see link to my merchant invoices index' do
      visit merchant_dashboards_path(Merchant.first)

      expect(page).to have_link("My Invoices")
    end

    #User story 3: Top 5 Customers
    xit 'I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant' do
      visit merchant_dashboards_path(Merchant.first)

      xwithin ("#top_customers") do
        expected_hash = {}

        expect(Merchant.first.top_five_customers).to eq(expected_hash)
      end
    end


    xit 'next to each customer name I see the number of successful transactions they have conducted with my merchant' do
      visit merchant_dashboards_path(Merchant.first)

      expected_hash = {}
      
      expect(page).to have_content(expected_hash)
    end
  end
end
