require 'rails_helper'

RSpec.describe 'Discounts Show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @discount1 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 5, percentage: 0.2)
    @discount2 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 10, percentage: 0.4)
  end
  it 'displays qauntity threshhold and percentage' do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"
    expect(page).to have_content("Discount: #{@discount1.id}, Show Page")
    expect(page).to have_content("Quantity Threshhold: 5")
    expect(page).to have_content("Percentage: 0.2")
    save_and_open_page
  end
end