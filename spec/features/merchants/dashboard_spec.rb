require 'rails_helper'

# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant

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

    it 'I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant' do
      visit merchant_dashboards_path(Merchant.first)

      within ("#favorite_customers") do

      end
    end

    it 'next to each customer name I see the number of successful transactions they have conducted with my merchant' do
      visit merchant_dashboards_path(Merchant.first)
      
    end
  end
end
