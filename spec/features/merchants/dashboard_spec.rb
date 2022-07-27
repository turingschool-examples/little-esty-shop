require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  it 'shows the name of the merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content('Fake Merchant')
  end

  it 'has a link to the merchants items index and merchant invoices index' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(current_path).to eq("/merchants/#{merchant1.id}/dashboard")
    expect(page).to have_link("Merchant Items Index")
    expect(page).to have_link("Merchant Invoices Index")
  end
end
