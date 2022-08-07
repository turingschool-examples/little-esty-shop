require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page' do
  before :each do
    @merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    @discount1 = BulkDiscount.create!(merchant_id: @merch1.id, percentage: 20, quantity_threshold: 10)
  end
  it 'can edit a bulk discount' do
    visit edit_merchant_bulk_discount_path(@merch1.id, @discount1.id)

    fill_in 'Percentage', with: 30
    fill_in 'Quantity Threshold', with: 3
    click_on 'Submit'

    expect(current_path).to eq(merchant_bulk_discount_path(@merch1.id, @discount1.id))
    expect(page).to have_content('Discount: 30%')
    expect(page).to have_content('Quantity Threshold: 3 Items')
    expect(BulkDiscount.last.percentage).to eq(30)
    expect(BulkDiscount.last.quantity_threshold).to eq(3)
  end
  it 'does not update if all fields are not filled, and gives error' do
    visit edit_merchant_bulk_discount_path(@merch1.id, @discount1.id)

    fill_in 'Percentage', with: 30
    click_on 'Submit'

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merch1.id, @discount1.id))
    expect(page).to have_content("Quantity threshold can't be blank")
  end
end
