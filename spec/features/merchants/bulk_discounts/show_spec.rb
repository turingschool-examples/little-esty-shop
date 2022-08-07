require 'rails_helper'

RSpec.describe 'Bulk Discount Show Page' do
  it 'shows the attributes for a bulk_discount' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)

    visit merchant_bulk_discounts_path(merch1.id)
    click_on('View Details')
    expect(current_path).to eq(merchant_bulk_discount_path(merch1.id, discount1.id))
    expect(page).to have_content('Discount: 20%')
    expect(page).to have_content('Quantity Threshold: 10 Items')
  end
  it 'has a link to edit this discount which takes me to the edit page' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)

    visit merchant_bulk_discount_path(merch1.id, discount1.id)
    expect(page).to have_link('Edit Discount')
    click_on('Edit Discount')
    expect(current_path).to eq(edit_merchant_bulk_discount_path(merch1.id, discount1.id))
  end
end
