require 'rails_helper'

RSpec.describe 'the merchant dashboard' do
  it 'shows the name of the merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_content('Fake Merchant')
  end

  it 'has links to merhant items index' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')

    visit "/merchants/#{merchant1.id}/dashboard"

    expect(page).to have_link("/merchants/#{merchant1.id}/items")
  end
end
