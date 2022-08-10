require 'rails_helper'
require './lib/holiday_search'

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
  it 'has a link to delete each discount' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)
    discount2 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 30, quantity_threshold: 3)

    visit merchant_bulk_discounts_path(merch1.id)
    within("#discount-#{discount1.id}") do
      expect(page).to have_link('Delete Discount')
    end
  end
  it 'clicking delete redirects me back to index and that discount is no longer there' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)
    discount2 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 30, quantity_threshold: 3)

    visit merchant_bulk_discounts_path(merch1.id)
    
    within("#discount-#{discount2.id}") do
      click_on('Delete Discount')
    end
    expect(current_path).to eq(merchant_bulk_discounts_path(merch1.id))
    expect(page).to_not have_content('Discount Percentage: 30%')
    expect(page).to_not have_content('Quantity Threshold: 3 Items')
  end
  it 'has a section for Upcoming Holidays with next 3 holidays' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 20, quantity_threshold: 10)
    discount2 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 30, quantity_threshold: 3)
    visit merchant_bulk_discounts_path(merch1.id)
# save_and_open_page
    within("#upcoming-holidays") do
      expect(page).to have_content('Upcoming Holidays')
      expect(page).to have_content('Labour Day')
      expect(page).to have_content('Columbus Day')
      expect(page).to have_content('Veterans Day')
    end
  end
end