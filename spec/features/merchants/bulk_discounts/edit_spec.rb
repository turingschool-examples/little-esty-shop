require 'rails_helper'

RSpec.describe 'bulk discounts edit' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
    @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
    @merchant_3 = Merchant.create!(name: 'Darkhorse', status: 'enabled')
    @merchant_4 = Merchant.create!(name: 'Image', status: 'disabled')
    @merchant_5 = Merchant.create!(name: 'Wonders', status: 'enabled')
    @merchant_6 = Merchant.create!(name: 'Disney', status: 'enabled')

    @discount_1 = BulkDiscount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percentage: 10, quantity_threshold: 2, merchant_id: @merchant_2.id)
  end

  it 'has a link to edit the discount on the show page' do
    visit merchant_bulk_discount_path(@merchant_1, @discount_1)

    expect(page).to have_button("Edit Discount")

    click_on "Edit Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @discount_1))
    fill_in :percentage, with: 12
    fill_in :quantity_threshold, with: 5
    click_on "Update Discount"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @discount_1))
    expect(page).to have_content("Percent Discount: 12")
    expect(page).to_not have_content("Percent Discount: #{@discount_1.percentage}")
    expect(page).to have_content("Quantity Threshold: #{@discount_1.quantity_threshold}")
  end

  it 'displays an error message if no content is put into form' do
    visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)

    fill_in :percentage, with: ""
    fill_in :quantity_threshold, with: 5
    click_on "Update Discount"

    expect(page).to have_content("Error! Please update fields with content")
  end
end