require 'rails_helper'

RSpec.describe "merchant's bulk discounts index" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  it "a merchant's bulk discounts index page lists all discounts, percentage discount, and quantity thresholds" do
    visit "/merchants/#{merchant1.id}/dashboard"
    allow(HolidayService).to receive(:find_holidays).and_return([{name: 'Juneteenth'}]) # example of stubbing instead of adding , :vcr

    click_link "Bulk Discounts Index"
    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts")

    within "#discount-#{discount1.id}" do
      expect(page).to have_content('20% Discount')
      expect(page).to have_content('Quantity: 10')
    end

    within "#discount-#{discount2.id}" do
      expect(page).to have_content('50% Discount')
      expect(page).to have_content('Quantity: 20')
    end
  end

  it "each bulk discount listed includes a link that directs you its show page", :vcr do
    visit "/merchants/#{merchant1.id}/discounts"

    click_link "20% Discount"

    expect(current_path).to eq(merchant_discount_path(merchant1.id, discount1.id))
  end

  it "has the next 3 federal holidays", :vcr do
    holidays = HolidayFacade.get_holidays

    visit "/merchants/#{merchant1.id}/discounts"

    within ".next_holidays" do
      expect(page).to have_content("Upcoming Holidays")
      holidays.each do |holiday|
        expect(page).to have_content(holiday.name)
      end
      expect(page).to_not have_content("Christmas")
    end
  end

  it "has a link to create a new discount", :vcr do
    visit "/merchants/#{merchant1.id}/discounts"

    click_link "Create a New Discount"

    expect(current_path).to eq(new_merchant_discount_path(merchant1))
  end

  it "has a delete button next to each discount", :vcr do
    visit "/merchants/#{merchant1.id}/discounts"

    within "#discount-#{discount1.id}" do
      expect(page).to have_content('20% Discount')
      expect(page).to have_content('Quantity: 10')
      click_button "Remove Discount"
    end

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts")
    expect(page).to_not have_content('20% Discount')
    expect(page).to_not have_content('Quantity: 10')
  end
end
