require 'rails_helper'

RSpec.describe 'Bulk Discount New Page' do
  it 'can create a new discount, and redirect to discounts index' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    visit new_merchant_bulk_discount_path(merch1.id)
    fill_in 'Percentage', with: 30
    fill_in 'Quantity Threshold', with: 3

    click_on "Submit"
    expect(current_path).to eq(merchant_bulk_discounts_path(merch1.id))
    expect(page).to have_content("Discount: 30%")
    expect(page).to have_content("Quantity Threshold: 3 Items")
    expect(BulkDiscount.last.merchant_id).to eq(merch1.id)
  end
  it 'will give an error if all fields are not filled and redirect to new page' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    visit new_merchant_bulk_discount_path(merch1.id)
    fill_in 'Percentage', with: 30
    
    click_on "Submit"
    expect(current_path).to eq(new_merchant_bulk_discount_path(merch1.id))
    expect(page).to have_content("Quantity threshold can't be blank")
  end
end