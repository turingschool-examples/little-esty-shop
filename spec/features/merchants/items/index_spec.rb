require 'rails_helper'

RSpec.describe 'the merchants items' do
  it 'is a list of all of the items that belong to a merchant' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit "/merchants/#{merchant1.id}/items"

    expect(page).to have_content('Name: Crap')
    expect(page).to have_content('Description: Because you buy stuff for no reason')
    expect(page).to have_content('Price: $99.99')
    expect(page).to have_content('Name: Junk')
    expect(page).to have_content('Description: You have room')
    expect(page).to have_content('Price: $109.99')
    expect(page).to have_content('Name: BS')
    expect(page).to have_content('Description: Filling the void in your life')
    expect(page).to have_content('Price: $119.99')
    expect(page).to_not have_content('Another Merchant')
    expect(page).to_not have_content('Name: Impracticality')
    expect(page).to_not have_content('Faux Merchant')
  end
end
