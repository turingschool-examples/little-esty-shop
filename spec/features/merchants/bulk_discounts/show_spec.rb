require 'rails_helper'

RSpec.describe 'merchant bulk discount show ' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    @discount1 = BulkDiscount.create(merchant_id: @merchant1.id, threshold: 15, discount: 10)
  end

  it 'displays both discount discount and threshold' do
    visit merchant_bulk_discount_path(@merchant1.id, @discount1.id)

    expect(page).to have_content("10%")
    expect(page).to have_content("15 items")
  end

end
