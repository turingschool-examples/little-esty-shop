require 'rails_helper'
RSpec.describe 'bulk discount new page' do
  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @bulk_discount_1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 15, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(quantity_threshold: 20, percentage: 20, merchant_id: @merchant.id)
    @bulk_discount_3 = BulkDiscount.create!(quantity_threshold: 30, percentage: 25, merchant_id: @merchant.id)
  end
  it 'has a form to add a new discount' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/new"

    expect(page).to have_content("Percentage:")
    expect(page).to have_content("Quantity Threshold:")
    expect(page).to have_button("Create Bulk Discount")
  end

  it 'redirects the user and loads the new discount when form is filled correctly' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/new"

    fill_in("percentage", with: "30")
    fill_in("quantity_threshold", with: "50")
    click_on("Create Bulk Discount")

    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts")

    expect(page).to have_content("50")
  end

  it 'displays a flash message error if the user fails to fill in the appropriate data' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/new"

    fill_in("percentage", with: "20")
    click_on("Create Bulk Discount")

    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/new")
    expect(page).to have_content("Please fill in valid information.")
  end
end
