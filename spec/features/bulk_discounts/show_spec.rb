require 'rails_helper'
RSpec.describe 'bulk discount show page' do
  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @bulk_discount_1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 15, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(quantity_threshold: 20, percentage: 20, merchant_id: @merchant.id)
    @bulk_discount_3 = BulkDiscount.create!(quantity_threshold: 30, percentage: 25, merchant_id: @merchant.id)
  end
  it 'shows the discounts quantity_threshold and percentage' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}"

    expect(page).to have_content(@bulk_discount_1.quantity_threshold)
    expect(page).to have_content(@bulk_discount_1.percentage)

    expect(page).to have_content("Quantity Threshold:")
    expect(page).to have_content("Percentage:")
  end
end
