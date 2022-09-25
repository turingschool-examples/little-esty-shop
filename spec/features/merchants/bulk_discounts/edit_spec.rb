require 'rails_helper'

RSpec.describe 'merchant bulk discount edit' do
  before :each do
    @merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
    @discount1 = BulkDiscount.create(merchant_id: @merchant1.id, threshold: 15, discount: 10)
  end

  it 'can use link to edit page' do
    visit merchant_bulk_discount_path(@merchant1.id, @discount1.id)
    click_on 'Edit this Offer'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@discount1.id}/edit")
  end

  it 'can visit the update page with fields prefilled' do
    visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@discount1.id}/edit"

    expect(page).to have_field('Discount', with: '10')
    expect(page).to have_field('Threshold', with: "15")
  end

  it 'can update a bulk discount' do
    visit "/merchants/#{@merchant1.id}/bulk_discounts/#{@discount1.id}/edit"

    fill_in 'Threshold', with: '25'
    fill_in 'Discount', with: '75'

    click_on 'Submit'

    expect(page).to have_content('25 items')
    expect(page).to have_content('75%')
  end
end
