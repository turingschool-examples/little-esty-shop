require 'rails_helper'

RSpec.describe 'the merchant show page' do
  it 'shows the merchants page' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Fake Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    visit merchant_path(merchant1)

    expect(page).to have_content('Name: Fake Merchant')

    visit merchant_path(merchant2)

    expect(page).to have_content('Name: Another Fake Merchant')

    visit merchant_path(merchant3)

    expect(page).to have_content('Name: Faux Merchant')
  end
end
