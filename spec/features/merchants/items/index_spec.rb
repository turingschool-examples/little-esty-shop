require 'rails_helper'

RSpec.describe 'merchant items index page' do
  it "only shows the names of the merchant's items" do
    merchant = Merchant.create!(name: 'Ted')
    item = Item.create!(name: 'Hammer', description: 'Hits stuff', unit_price: 24, merchant_id: merchant.id)
    item2 = Item.create!(name: 'Mop', description: 'Cleans stuff', unit_price: 48, merchant_id: merchant.id)

    merchant2 = Merchant.create!(name: 'Bob')
    item3 = Item.create!(name: 'Shovel', description: 'Scoops stuff', unit_price: 25, merchant_id: merchant2.id)
    item4 = Item.create!(name: 'Funnel', description: 'Funnels stuff', unit_price: 23, merchant_id: merchant2.id)

    visit merchant_items_path(merchant)

    expect(page).to have_content(item.name)
    expect(page).to have_content(item2.name)

    expect(page).not_to have_content(item3.name)
    expect(page).not_to have_content(item4.name)
  end

  it "has item links that take the merchant to the item's show page" do
    merchant = Merchant.create!(name: 'Ted')
    item = Item.create!(name: 'Hammer', description: 'Hits stuff', unit_price: 24, merchant_id: merchant.id)

    visit merchant_items_path(merchant)

    click_on("#{item.name}")

    expect(current_path).to eq(merchant_item_path(merchant,item))
  end
end
