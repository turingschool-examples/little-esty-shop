require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page' do
  it 'shows all merchant bulk discounts with attributes' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')
    # merch3 = Merchant.create!(name: 'Treats and Things')

    merch1.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
    merch1.bulk_discounts.create!(percentage: 10, quantity_threshold: 5)
    merch2.bulk_discounts.create!(percentage: 10, quantity_threshold: 2)
    merch2.bulk_discounts.create!(percentage: 20, quantity_threshold: 5)

    visit merchant_bulk_discounts_path(merch1.id)

    within('#discount-list') do
      expect(page).to have_content("Discount: 20%")
      expect(page).to have_content("Quantity Threshold: 10 Items")
      expect(page).to have_link('View Details',  count: 2)
      expect(page).to_not have_content("Quantity Threshold: 2 Items")
    end
  end
  it 'View Details link takes you to the show page for the discount' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)

    visit merchant_bulk_discounts_path(merch1.id)
    click_on('View Details')
    expect(current_path).to eq(merchant_bulk_discount_path(merch1.id, discount1.id))
    
  end
  it 'has a link to create a new discount' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')

    visit merchant_bulk_discounts_path(merch1.id)
    
    click_on('Create New Discount')
    expect(current_path).to eq(new_merchant_bulk_discount_path(merch1.id))
  end
end