require 'rails_helper'

RSpec.describe 'merchants items index' do
  it 'lists all of the merchants items' do
    visit '/merchants/1/items'

    merchant = Merchant.find(1)
    expect(page).to have_content(merchant.name)
    merchant.items.each do |item|
      expect(page).to have_content(item.name)
      expect(page).to have_link(item.name, href: "/merchants/1/items/#{item.id}")
    end
    (16..174).to_a.each do |num|
      expect(page).to_not have_content(Item.find(num).name)
    end
  end
end
