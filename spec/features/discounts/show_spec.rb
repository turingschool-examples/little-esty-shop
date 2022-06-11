require 'rails_helper'

RSpec.describe "merchant's bulk discounts show page" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  # let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  it "displays a discount's pertentage and quantity threshold", :vcr do
    visit merchant_discount_path(merchant1.id, discount1.id)

    expect(page).to have_content('20% Discount')
    expect(page).to have_content('Quantity: 10')
  end
end
