require 'rails_helper'
RSpec.describe 'bulk discount index page' do
  before :each do
    @merchant = Merchant.create!(name: 'AnnaSellsStuff')
    @bulk_discount_1 = BulkDiscount.create!(quantity_threshold: 10, percentage: 15, merchant_id: @merchant.id)
    @bulk_discount_2 = BulkDiscount.create!(quantity_threshold: 20, percentage: 20, merchant_id: @merchant.id)
    @bulk_discount_3 = BulkDiscount.create!(quantity_threshold: 30, percentage: 25, merchant_id: @merchant.id)

  end
  it 'has all bulk discounts listed with their attributes' do
    visit "merchants/#{@merchant.id}/bulk_discounts"

    expect(page).to have_content(@bulk_discount_1.quantity_threshold)
    expect(page).to have_content(@bulk_discount_2.quantity_threshold)
    expect(page).to have_content(@bulk_discount_3.quantity_threshold)

    expect(page).to have_content(@bulk_discount_1.percentage)
    expect(page).to have_content(@bulk_discount_2.percentage)
    expect(page).to have_content(@bulk_discount_3.percentage)
  end

  it 'has a link to each discounts show page' do
    visit "merchants/#{@merchant.id}/bulk_discounts"

    expect(page).to have_link("Discount Show Page", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_1.id}")
    expect(page).to have_link("Discount Show Page", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_2.id}")
    expect(page).to have_link("Discount Show Page", href: "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount_3.id}")
  end

  it 'has a link to the bulk discount new page' do
    visit "merchants/#{@merchant.id}/bulk_discounts"

    expect(page).to have_link("Create New Bulk Discount")

    click_on("Create New Bulk Discount")
    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts/new")
  end

  it 'has a button to delete each discount' do
    visit "/merchants/#{@merchant.id}/bulk_discounts"

    within("#discount#{@bulk_discount_1.id}") do
      expect(page).to have_button("Delete Discount")
    end
    within("#discount#{@bulk_discount_2.id}") do
      expect(page).to have_button("Delete Discount")
    end
    within("#discount#{@bulk_discount_3.id}") do
      expect(page).to have_button("Delete Discount")
    end
  end

  it 'deletes the discount from the index when delete button is pressed' do
    visit "/merchants/#{@merchant.id}/bulk_discounts"

    within("#discount#{@bulk_discount_1.id}") do
      click_button("Delete Discount")
    end
    expect(page).to have_no_content(@bulk_discount_1.id)
  end

  it 'has the next 3 holidays in the USA listed with their name and date' do
    visit "/merchants/#{@merchant.id}/bulk_discounts"

    expect(page).to have_content("Independence Day")
    expect(page).to have_content("Labour Day")
    expect(page).to have_content("Columbus Day")
    expect(page).to have_content("2021-07-05")
    expect(page).to have_content("2021-09-06")
    expect(page).to have_content("2021-10-11")

    expect("Independence Day").to appear_before("Labour Day")
    expect("Labour Day").to appear_before("Columbus Day")

    expect("2021-07-05").to appear_before("2021-09-06")
    expect("2021-09-06").to appear_before("2021-10-11")
  end
end
