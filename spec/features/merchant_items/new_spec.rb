require 'rails_helper'

RSpec.describe 'When I visit the merchant items index page' do
  it 'I see a link to create a new item' do
    merchant = Merchant.create!(name: 'Yeti')
    merchant_2 = Merchant.create!(name: 'Hydroflask')
    item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
    item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')

    visit "/merchants/#{merchant.id}/items"
    click_link "Create New Item"
    expect(current_path).to eq("/merchants/#{merchant.id}/items/new")
  end

  it 'I am taken to a form that allows me to add item information' do
    merchant = Merchant.create!(name: 'Yeti')
    merchant_2 = Merchant.create!(name: 'Hydroflask')
    item_1 = merchant.items.create!(name: 'Bottle', unit_price: 10, description: 'H20')
    item_2 = merchant.items.create!(name: 'Can', unit_price: 5, description: 'Soda')
    item_3 = merchant.items.create!(name: 'Mug', unit_price: 15, description: 'Coffee')
    item_4 = merchant_2.items.create!(name: 'Kettle', unit_price: 20, description: 'Tea')

    visit "/merchants/#{merchant.id}/items/new"
    fill_in 'name', with: 'test'
    fill_in 'unit_price', with: '35'
    fill_in 'description', with: 'container'
    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content('test')
  end
end