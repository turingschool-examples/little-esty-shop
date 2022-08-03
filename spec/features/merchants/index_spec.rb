require 'rails_helper'

RSpec.describe 'the merchants index' do
  it 'shows the merchants page and all of their items' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit "/merchants"

    expect(page).to have_content('Fake Merchant')
    expect(page).to have_content('Another Merchant')
    expect(page).to have_content('Faux Merchant')
  end

  it 'has a link as each merchants name that takes to the dashboard' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit "/merchants"

    expect(page).to have_link('Fake Merchant')
    expect(page).to have_link('Another Merchant')
    expect(page).to have_link('Faux Merchant')

    click_link('Fake Merchant')
    expect(current_path).to eq("/merchants/#{merchant1.id}/dashboard")
  end
end
