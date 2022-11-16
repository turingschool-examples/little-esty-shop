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
  end
  it 'can update a discount' do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"
    click_on "Update Discount"
    fill_in :quantity_threshhold, with: '50'
    fill_in :percentage, with: '0.6'
    click_on "Submit"
    expect(page).to have_content("Discount: #{@discount1.id}, Show Page")
    expect(page).to have_content("Quantity Threshhold: 50")
    expect(page).to have_content("Percentage: 0.6")
  end
 
end