require 'rails_helper'

RSpec.describe "merchant's new discount form" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:discount1) { merchant1.discounts.create!(percentage: 20, quantity_threshold: 10) }
  let!(:discount2) { merchant1.discounts.create!(percentage: 50, quantity_threshold: 20) }

  it "can fill in percentage discount and quantity fields and click submit to be redirected to merchant's bulk discount index where the discount has been added", :vcr do
    visit new_merchant_discount_path(merchant1)

    fill_in :percentage, with: "75"
    fill_in :quantity_threshold, with: "50"
    click_button "Submit"

    expect(current_path).to eq(merchant_discounts_path(merchant1))
  end
end
