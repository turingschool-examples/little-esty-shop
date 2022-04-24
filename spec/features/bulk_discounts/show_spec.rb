require "rails_helper"

RSpec.describe "Bulk discounts show page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount_a.id}"
  end

  it "shows bulk discount info" do
    expect(page).to have_content("Percentage: 0.1")
    expect(page).to have_content("Quantity: 10000")

    expect(page).to_not have_content("Percentage: 0.2")
    expect(page).to_not have_content("Quantity: 40000")
  end

  it "links to bulk discounts edit page" do
    click_link "Edit"
    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount_a.id}/edit")
  end
end
