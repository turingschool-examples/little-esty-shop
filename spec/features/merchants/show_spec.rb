require 'rails_helper'

RSpec.describe 'The merchants dashboard' do
  it 'displays links to the merchant items index and the merchant invoices index' do
    merchant_1 = Merchant.create!(name: "Test Merchant")
    visit "/merchants/#{merchant_1.id}/dashboard"

    expect(page).to have_link("Merchant Items")
    # click_link("Merchant Items")
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

    # visit "/merchants/#{merchant_1.id}/dashboard"

    expect(page).to have_link("Merchant Invoices")
    # click_link("Merchant Invoices")
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
  end
end
