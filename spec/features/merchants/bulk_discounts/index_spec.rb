require 'rails_helper'

RSpec.describe 'merchant bulk discount index page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    @merchant2 = Merchant.create!(name: "Paul Revere", status: 'Enabled')

    @discount1 = BulkDiscount.create(merchant_id: @merchant1.id, threshold: 15, discount: 10)
    @discount2 = BulkDiscount.create(merchant_id: @merchant2.id, threshold: 25, discount: 20)
    @discount3 = BulkDiscount.create(merchant_id: @merchant2.id, threshold: 35, discount: 30)
  end

  it 'has a button on merchant dashboard to redirect you to bulk discounts index' do
    visit "/merchants/#{@merchant1.id}/dashboard"

    click_on "View all Discounts"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
  end

  it 'can display the the percent off and threshold for the discount' do
    visit "/merchants/#{@merchant1.id}/bulk_discounts"

    expect(page).to have_content("15 items")
    expect(page).to have_content("10%")
  end

  it 'has a link to the offer show page' do
    visit merchant_bulk_discounts_path(@merchant1.id)

    expect(page).to have_content("View this Offer")

    click_on "View this Offer"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@discount1.id}")
  end


end
