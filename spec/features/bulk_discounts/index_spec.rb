require "rails_helper"

RSpec.describe "Bulk discounts index page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant_id: merchant.id, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant_id: merchant.id, percentage: 0.20, quantity: 40000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts"
  end

  it "has bulk discounts" do
    expect(page).to have_content("Percentage: 10")
    expect(page).to have_content("Quantity: 10000")

    expect(page).to have_content("Percentage: 20")
    expect(page).to have_content("Quantity: 40000")
  end
end
