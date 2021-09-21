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
    click_on "#{item_1.name}"

    expect(current_path).to eq(merchant_item_path(merchant, item_1))
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content(item_1.unit_price)
  end

  it 'has a link to create a new merchant item' do
    merchant = Merchant.create!(name: "Tony")

    visit merchant_items_path(merchant)
    click_on "Create new item"

    expect(current_path).to eq(new_merchant_item_path(merchant))
  end

  describe 'enabled disabled items list' do
    it 'has a button to enable the item status' do
      merchant = Merchant.create!(name: "Tony")
      item_1 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30, status: 'disabled' )
      item_2 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50, status: 'enabled')

      visit (merchant_items_path(merchant))

      expect(page).to have_button("Enable Item")
      within("#Item-#{item_1.id}") do
        click_on("Enable Item")
        expect(current_path).to eq("/merchants/#{merchant.id}/items")
      end
      within("#Enabled") do
        expect(page).to have_content(item_1.name)
      end

    end

    it 'has a button to disable the item status' do
      merchant = Merchant.create!(name: "Tony")
      item_1 = merchant.items.create!(name: "Pants", description: "Black pants", unit_price: 50, status: 'enabled')
      item_2 = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30, status: 'disabled')

      visit (merchant_items_path(merchant))

      expect(page).to have_button("Enable Item")

      within("#Item-#{item_1.id}") do
        click_on("Disable Item")
        expect(current_path).to eq("/merchants/#{merchant.id}/items")
      end
      within("#Disabled") do
        expect(page).to have_content(item_1.name)
      end

    end
  end

end
