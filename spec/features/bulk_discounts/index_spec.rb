require 'rails_helper'

RSpec.describe 'Merchants Bulk Discount index' do 
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
    
    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 10, quantity:  15, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(percentage_discount: 15, quantity:  20, merchant_id: @merchant_1.id)
    @discount_4 = BulkDiscount.create!(percentage_discount: 20, quantity:  30, merchant_id: @merchant_1.id)
  end
  
  it 'will display all of the current bulk discounts' do 
    # expect(current_path).to eq(merchant_bulk_discounts_path)
    visit merchant_bulk_discounts_path(@merchant_1)
    
    expect(page).to have_content("All discounts")
    # Where I see all of my bulk discounts including their
    # percentage discount and quantity thresholds
    within("#discount-#{@discount_1.id}") do 
      expect(page).to have_content(@discount_1.percentage_discount)
      expect(page).to have_content(@discount_1.quantity)
    end 

    within("#discount-#{@discount_2.id}") do 
      expect(page).to have_content(@discount_2.percentage_discount)
      expect(page).to have_content(@discount_2.quantity)
    end 
  end 
  
  it 'will have a link to each individual bulk discount show page' do 
    visit merchant_bulk_discounts_path(@merchant_1)

    within("#discount-#{@discount_1.id}") do 
      click_link 'Discount Details'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @discount_1))
    end 
    # And each bulk discount listed includes a link to its show page
  end 
end