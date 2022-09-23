require 'rails_helper'

RSpec.describe 'New Bulk Discounts page' do 
  before :each do 
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
  end 

  it 'will have a form to fill in' do 
    visit new_merchant_bulk_discount_path(@merchant_1)
    # When I fill in the form with valid data
    fill_in "Percentage Discount", with: 30
    fill_in "Quantity Threshold", with: 25

    click_button "Create New Bulk Discount"
    # Then I am redirected back to the bulk discount index
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    # And I see my new bulk discount listed
    expect(page).to have_content("Percentage Discount: 30%")
    expect(page).to have_content("Quantity: 25 items")
  end 
end 