require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope')}
  let!(:merchant_3) {Merchant.create!(name: 'Oprah Winfrey')}
  let!(:merchant_4) {Merchant.create!(name: 'Leonardo Dicaprio')}
  
  scenario 'visitor sees the names of each merchant in the system' do
    visit admin_merchants_path

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
    expect(page).to have_content(merchant_4.name)
  end
end
