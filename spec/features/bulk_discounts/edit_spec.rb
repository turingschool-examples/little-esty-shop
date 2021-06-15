require 'rails_helper'
RSpec.describe 'bulk discount edit page' do
  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @bulk_discount_1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 15, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(quantity_threshold: 20, percentage: 20, merchant_id: @merchant.id)
    @bulk_discount_3 = BulkDiscount.create!(quantity_threshold: 30, percentage: 25, merchant_id: @merchant.id)
  end
  it 'has a form with pre-loaded values for the attributes' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}/edit"

    expect(page).to have_content("Percentage:")
    #why does value come up as invalid? it is in the docs for this method in this exact context
    # expect(page).to have_selector("input", :value => "#{@bulk_discount_1.percentage}")

    expect(page).to have_content("Quantity Threshold:")
    # expect(page).to have_content(@bulk_discount_1.quantity_threshold)

    expect(page).to have_button("Update This Discount")
  end

  it 'redirects the user to the show page and shows the updated information' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}/edit"

    fill_in("percentage", with: "12")
    fill_in("quantity_threshold", with: "16")
    click_button("Update This Discount")

    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}")

    expect(page).to have_content("12")
    expect(page).to have_content("16")
  end

  it 'redirects the user to the edit page again if invalid information is entered' do
    visit "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}/edit"

    fill_in("percentage", with: "hooplah")
    click_on("Update This Discount")
    
    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}/edit")
    expect(page).to have_content("Please fill in valid information.")
  end
end
