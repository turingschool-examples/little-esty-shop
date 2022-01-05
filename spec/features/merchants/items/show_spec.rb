require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do

  it "lists an item's attributes" do
    merchant1 = Merchant.create!(name: 'merchant1')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)

    visit merchant_item_path(merchant1, item1)
    within ".item" do
      expect(page).to have_content("#{item1.name}'s Info")
      expect(page).to have_content("#{item1.name}")
      expect(page).to have_content("#{item1.description}")
      expect(page).to have_content("#{item1.unit_price}")
    end
  end

  it 'sees link to update item info. link takes user to edit page of that item' do
    merchant1 = Merchant.create!(name: 'merchant1')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)

    visit merchant_item_path(merchant1, item1)

    within ".item" do
      click_link "Update #{item1.name}"
      expect(current_path).to eq(edit_merchant_item_path(merchant1, item1))
    end
  end
end
