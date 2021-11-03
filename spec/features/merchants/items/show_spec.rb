require 'rails_helper'

RSpec.describe 'show page' do
  it "shows the item's attributes" do
    merchant = Merchant.create!(name: 'Ted')
    item = Item.create!(name: 'Hammer', description: 'Hits stuff', unit_price: 24, merchant_id: merchant.id)

    merchant2 = Merchant.create!(name: 'Bob')
    item2 = Item.create!(name: 'Rock', description: 'I rock', unit_price: 5, merchant_id: merchant2.id)

    visit merchant_item_path(merchant,item)

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.unit_price)

    expect(page).not_to have_content(item2.name)
    expect(page).not_to have_content(item2.description)
    expect(page).not_to have_content(item2.unit_price)
  end
end
