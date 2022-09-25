require 'rails_helper'

RSpec.describe 'merchant bulk discount show ' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    @discount1 = BulkDiscount.create(merchant_id: @merchant1.id, threshold: 15, discount: 10)
  end

  it 'can delete a discount' do
    visit "/merchants/#{@merchant1.id}/bulk_discounts"

    expect(page).to have_content("10%")
    click_on 'Remove this Discount'

    expect(page).to_not have_content("10%")
  end

end
