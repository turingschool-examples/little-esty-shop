require 'rails_helper'

RSpec.describe "merchant's bulk discounts index" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  # Merchant Bulk Discounts Index
  #
  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page

  it "a merchant's bulk discounts index page lists all discounts, percentage discount, and quantity thresholds" do
    visit "/merchants/#{merchant1.id}/"

    click_link "Bulk Discounts Index"

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts")
    within "discount-#{discount1}" do
      expect(page).to have_content('Percentage Discount: 20')
      expect(page).to have_content('Quantity Threshold: 10')
    end

    within "discount-#{discount2}" do
      expect(page).to have_content('Percentage Discount')
      expect(page).to have_content('Quantity Threshold')
    end

  end


  it "each bulk discount listed includes a link directs you its show page" do

  end

  it "has the next 3 federal holidays", :vcr do
    visit "/merchants/#{merchant1.id}/discounts"

    holidays = HolidayFacade.get_holidays

    within ".next_holidays" do
      expect(page).to have_content("Upcoming Holidays")
      holidays.each do |holiday|
        expect(page).to have_content(holiday.name)
      end
      expect(page).to_not have_content("Christmas")
    end
  end
end
