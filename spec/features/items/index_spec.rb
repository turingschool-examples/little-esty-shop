require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do

  it 'shows the names of all items of that merchant' do
    merchant = Merchant.create!(name: "Tony")
    item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)
    item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50)

    visit (merchant_items_path(merchant))

    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
  end

  it 'has a link to take you to the merchant items show page' do
    merchant = Merchant.create!(name: "Tony")
    item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)
    item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50)

    visit (merchant_items_path(merchant))
    click_on "Shirt"

    expect(current_path).to eq(merchant_item_path(item_1))
  end
end
