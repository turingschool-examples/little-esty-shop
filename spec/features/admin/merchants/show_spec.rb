require 'rails_helper'
describe 'Admin Merchant show page' do
  it 'I see the name of that merchant' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    merchant_2 = Merchant.create!(name: 'merchant_2')
    merchant_3 = Merchant.create!(name: 'merchant_3')
    visit "/admin/merchants/#{merchant_1.id}"
    expect(page).to have_content("Merchant Name: #{merchant_1.name}")
  end

  it 'I see a link to update the merchants information' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    visit "/admin/merchants/#{merchant_1.id}"

    expect(page).to have_link("Update Merchant")
  end
end
