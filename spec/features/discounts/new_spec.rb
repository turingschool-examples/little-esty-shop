require 'rails_helper'

RSpec.describe "Merchant Discount New Page" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  it "displays a form to add a new discount, when I submit the discount I am redirected to the merchant's bulk discount index where the discount has been added" do
    visit new_merchant_discount_path(merchant1)

    fill_in :percentage, with: "75"
    fill_in :quantity_threshold, with: "50"
    click_button "Submit"

    expect(current_path).to eq(merchant_discounts_path(merchant1))
  end
end
