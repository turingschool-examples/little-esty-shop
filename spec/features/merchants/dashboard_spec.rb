require 'rails_helper'

RSpec.describe 'merchant dashboard page' do
   it 'shows the merchants name' do

        merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content(merchant_1.name)
  end

  it 'links to merchant items' do
    merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
    visit "/merchants/#{merchant_1.id}/dashboard"
    click_link("This Merchant's Items")
    expect(page).to have_current_path("/merchants/#{merchant_1.id}/items")
  end

  it 'links to merchant invoices' do
    merchant_1 = Merchant.create!(name: "Geddy's Skydiving Emporium")
    visit "/merchants/#{merchant_1.id}/dashboard"
    click_link("This Merchant's Invoices")
    expect(page).to have_current_path("/merchants/#{merchant_1.id}/invoices")
  end
end
