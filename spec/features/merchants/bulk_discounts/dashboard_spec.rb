require 'rails_helper'

RSpec.describe 'Merchant Dashboard - Bulk Discounts' do
  before :each do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
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

    end

    it 'When I click this link Then I am taken to my bulk discounts index page' do

    end

    it 'Where I see all of my bulk discounts including their percentage discount and quantity thresholds' do

    end

    it 'And each bulk discount listed includes a link to its show page' do

    end
  end
end