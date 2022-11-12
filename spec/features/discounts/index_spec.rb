require 'rails_helper'

RSpec.describe 'Discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @discount1 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 5, percentage: 0.2 )
    @discount2 = Discount.create!(merchant_id: @merchant1.id, quantity_threshhold: 10, percentage: 0.4)
  end
  it 'has a link to a working create form' do
    visit "/merchants/#{@merchant1.id}/discounts"
    click_on "Create a new discount"
    fill_in :quantity_threshhold, with: "20"
    fill_in :percentage, with: ".5"
    click_on "Submit"

    expect(page).to have_content("Discount Quantity Threshhold: 20")
    expect(page).to have_content("Discount Percentage: 0.5")
    save_and_open_page
end
end 