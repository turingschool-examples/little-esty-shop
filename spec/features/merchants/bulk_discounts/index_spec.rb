require 'rails_helper'

RSpec.describe 'merchant bulk items index' do
  let!(:merchant_1) { Merchant.create!(name: Faker::Name.unique.name) }
  let!(:merchant_2) { Merchant.create!(name: Faker::Name.unique.name) }

  let!(:disc_10m1) { 
    merchant_1.bulk_discounts.create!(
      discount_percent: 10,
      quantity_threshold: 5
    )
  }
  let!(:disc_15m1) { 
    merchant_1.bulk_discounts.create!(
      discount_percent: 15,
      quantity_threshold: 8
    )
  }
  let!(:disc_20m1) { 
    merchant_1.bulk_discounts.create!(
      discount_percent: 20,
      quantity_threshold: 10
    )
  }

  let!(:disc_30m2) { 
    merchant_2.bulk_discounts.create!(
      discount_percent: 30,
      quantity_threshold: 20
    )
  }
  let!(:disc_25m2) { 
    merchant_2.bulk_discounts.create!(
      discount_percent: 25,
      quantity_threshold: 10
    )
  }

  before :each do
    visit merchant_bulk_discounts_path(merchant_1)
  end

  it 'displays all of my bulk discounts' do

    expect(page).to have_content(merchant_1.name)

    within "#discount-#{disc_10m1.id}" do
      expect(page).to have_content("#{disc_10m1.discount_percent}% off #{disc_10m1.quantity_threshold} or more items!")
    end

    within "#discount-#{disc_15m1.id}" do
      expect(page).to have_content("#{disc_15m1.discount_percent}% off #{disc_15m1.quantity_threshold} or more items!")
    end

    within "#discount-#{disc_20m1.id}" do
      expect(page).to have_content("#{disc_20m1.discount_percent}% off #{disc_20m1.quantity_threshold} or more items!")
    end

    expect(page).to_not have_content(merchant_2.name)
    expect(page).to_not have_css("#discount-#{disc_30m2.id}")
    expect(page).to_not have_css("#discount-#{disc_25m2.id}")
  end
end