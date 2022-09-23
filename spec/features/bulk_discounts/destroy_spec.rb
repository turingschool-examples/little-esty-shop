require 'rails_helper'

RSpec.describe 'delete a discount' do 
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
    
    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 10, quantity:  15, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percentage_discount: 15, quantity:  20, merchant_id: @merchant_1.id)
    @discount_4 = BulkDiscount.create!(percentage_discount: 20, quantity:  30, merchant_id: @merchant_1.id)
  end   
  
  it 'will have delete functionality' do 
    # When I visit my bulk discounts index
    visit merchant_bulk_discounts_path(@merchant_1)
    # Then next to each bulk discount I see a link to delete it
    within("#discount-#{@discount_1.id}") do 
      expect(page).to have_link("Delete Discount")
      # When I click this link
      click_link("Delete Discount")
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
      # Then I am redirected back to the bulk discounts index page
    end 
    # And I no longer see the discount listed
    expect(page).to_not have_content("Percentage Discount: 5%")
    expect(page).to_not have_content("Quantity Threshold: 10 items")
  end 
end 