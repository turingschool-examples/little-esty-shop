require "rails_helper"

RSpec.describe "Bulk discounts new page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  let!(:other_merchant) { Merchant.create!(name: "Not Rebekah's Circuits") }
  let!(:bulk_discount_c) { BulkDiscount.create!(merchant: other_merchant, percentage: 0.50, quantity: 60000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts/new"
  end

  it "creates new bulk discount" do
  end
end
