require "rails_helper"

RSpec.describe "Bulk discounts edit page" do
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:merchant) { Merchant.create!(name: "Rebekah's Circuits") }
  let!(:bulk_discount_a) { BulkDiscount.create!(merchant: merchant, percentage: 0.10, quantity: 10000) }
  let!(:bulk_discount_b) { BulkDiscount.create!(merchant: merchant, percentage: 0.20, quantity: 40000) }

  before :each do
    visit "/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount_a.id}/edit"
  end

  it "has form to edit bulk discount" do
    expect(page).to have_field("Percentage (as decimal):", with: "0.1")
    expect(page).to have_field("Quantity:", with: "10000")

    expect(page).to_not have_field("Percentage (as decimal): 0.2")
    expect(page).to_not have_field("Quantity: 40000")
  end

  it "edits bulk discount" do
    fill_in "Percentage (as decimal):", with: "0.99"
    fill_in "Quantity", with: "90000"
    click_button("Update")

    expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount_a.id}")
    expect(page).to have_content("Percentage: 0.99")
    expect(page).to have_content("Quantity: 90000")

    expect(page).to_not have_content("Percentage: 0.1")
    expect(page).to_not have_content("Quantity: 10000")
  end
end
