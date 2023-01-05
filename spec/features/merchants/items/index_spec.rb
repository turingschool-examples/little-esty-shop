require 'rails_helper'

RSpec.describe 'merchants items index' do
  it 'lists all of the merchants items' do
    visit merchant_items_path(1)

    merchant = Merchant.find(1)
    expect(page).to have_content(merchant.name)
    merchant.items.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_link(item.name, href: merchant_item_path(1, item))
    end
    (16..174).to_a.each do |num|
      expect(page).to_not have_content(Item.find(num).name)
    end
  end

  it 'has a button to enable or disable items' do
    item = Item.find(10)
    visit merchant_items_path(1)

    within "div#item-#{item.id}" do
      expect(page).to have_button("Disable")
      click_button "Disable"
    end

    item = Item.find(10)
    expect(current_path).to eq(merchant_items_path(1))

    within "div#item-#{item.id}" do
      expect(page).to have_button("Enable")
      click_button "Enable"
    end

    item = Item.find(10)
    expect(current_path).to eq(merchant_items_path(1))

    within "div#item-#{item.id}" do
      expect(page).to have_button("Disable")
    end
  end
end
