require 'rails_helper'

describe 'merchant dashboard page' do
  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
      created_at: Date.current,
      updated_at: Date.current
    )
  end

  it 'displays the merchants name' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Store Store")
  end
end
