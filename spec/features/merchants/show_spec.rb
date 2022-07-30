require 'rails_helper'

RSpec.describe 'the merchant show page' do
  it 'shows the merchants page and all of their items' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit merchant_path(merchant1)

    expect(page).to have_content('Fake Merchant')
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

    visit merchant_path(merchant2)

    expect(page).to have_content('Another Merchant')
    expect(page).to have_content('Name: Impracticality')
    expect(page).to have_content('Description: Underselling the other guy')
    expect(page).to have_content('Price: $119.98')
    expect(page).to_not have_content('Fake Merchant')
    expect(page).to_not have_content('Faux Merchant')

    visit merchant_path(merchant3)

    expect(page).to have_content('Faux Merchant')
    expect(page).to_not have_content('Fake Merchant')
    expect(page).to_not have_content('Another Merchant')
  end

  it 'item name is a link to that items page' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit merchant_path(merchant2)

    expect(page).to have_link('Impracticality')
    expect(page).to_not have_link('Crap')
    expect(page).to_not have_link('Junk')
    expect(page).to_not have_link('BS')

    click_link('Impracticality')

    expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{merch2item.id}")
    expect(page).to have_content('Description: Underselling the other guy')
    expect(page).to have_content('Price: $119.98')
    expect(page).to_not have_content('Description: Filling the void in your life')
    expect(page).to_not have_content('Price: $119.99')

    visit merchant_path(merchant1)

    expect(page).to have_content('Fake Merchant')
    expect(page).to have_link('Crap')
    expect(page).to have_link('Junk')
    expect(page).to have_link('BS')
    expect(page).to_not have_link('Impracticality')

    click_link('Crap')

    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
    expect(page).to have_content('Description: Because you buy stuff for no reason')
    expect(page).to have_content('Price: $99.99')
    expect(page).to_not have_content('Description: Filling the void in your life')
    expect(page).to_not have_content('Price: $119.99')
    expect(page).to_not have_content('Description: Underselling the other guy')
    expect(page).to_not have_content('Price: $119.98')

    visit merchant_path(merchant1)
    click_link('Junk')

    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item2.id}")
    expect(page).to have_content('Description: You have room')
    expect(page).to have_content('Price: $109.99')

    visit merchant_path(merchant1)
    click_link('BS')

    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item3.id}")
    expect(page).to have_content('Description: Filling the void in your life')
    expect(page).to have_content('Price: $119.99')
  end
end
