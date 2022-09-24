require 'rails_helper'

RSpec.describe 'Merchant Dashboard - Bulk Discounts' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page

  describe 'User Story 1 - When I visit my merchant dashboard' do 
    it 'Then I see a link to view all my discounts' do
      visit  merchant_dashboard_path(@merchant_1)
      
      find_link({text: "Bulk Discount Index", href: merchant_bulk_discounts_path(@merchant_1)}).visible?

      visit  merchant_dashboard_path(@merchant_2)

      find_link({text: "Bulk Discount Index", href: merchant_bulk_discounts_path(@merchant_2)}).visible?
    end

    it 'When I click this link Then I am taken to my bulk discounts index page' do
      visit  merchant_dashboard_path(@merchant_1)

      click_on "Bulk Discount Index"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))

      visit  merchant_dashboard_path(@merchant_2)

      click_on "Bulk Discount Index"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_2))
    end

    it 'Where I see all of my bulk discounts including their percentage discount and quantity thresholds' do

    end

    it 'And each bulk discount listed includes a link to its show page' do

    end
  end
end