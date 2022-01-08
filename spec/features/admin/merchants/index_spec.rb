require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  scenario 'visitor sees the names of each merchant in the system' do
    merchant_1 = Merchant.create!(name: 'Ron Swanson')
    merchant_2 = Merchant.create!(name: 'Leslie Knope')
    merchant_3 = Merchant.create!(name: 'Tom Haverford')
    merchant_4 = Merchant.create!(name: 'April Ludgate')

    visit admin_merchants_path

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
    expect(page).to have_content(merchant_4.name)
  end
end
