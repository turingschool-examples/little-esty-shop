require 'rails_helper'

# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
#
# Merchant Item Disable/Enable
#
# As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed

RSpec.describe 'Merchants Index' do

  before :each do
    @merchant_1 = Merchant.create!(name: "Ana Maria")
    @merchant_2 = Merchant.create!(name: "Juan Lopez")
    @merchant_3 = Merchant.create!(name: "Jamie Fergerson")
    @item_1 = @merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, status: 1)
    @item_2 = @merchant_1.items.create!(name: "onion", description: "red onion", unit_price: 3450, status: 1)
    @item_3 = @merchant_2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
    @item_4 = @merchant_2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, status: 1)
    @item_5 = @merchant_2.items.create!(name: "ring", description: "red onion", unit_price: 34)
    @item_6 = @merchant_3.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, status: 1)
    @item_7 = @merchant_3.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, status: 1)
    @item_8 = @merchant_3.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)

  end

  it 'can see a list of the names of all of the items' do
    visit "/merchants/#{@merchant_1.id}/items"
require "pry"; binding.pry
    within("#item-0") do

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.display_price)
    expect(page).to_not have_content(@item_2.name)
    end
  end

  it 'can see an enable/ disable button next to each item' do
    visit "/merchants/#{@merchant_2.id}/items"

    within("#item-0") do

      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content(@item_3.display_price)
      expect(page).to have_button("Enable #{@item_3.name}")

    end

    within("#item-1") do
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.description)
      expect(page).to have_content(@item_4.display_price)
      expect(page).to have_button("Disable #{@item_4.name}")

    end

    within("#item-2") do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Enable #{@item_5.name}")

    end

    click_button "Enable #{@item_5.name}"
    expect(current_path).to eq("/merchants/#{@merchant_2.id}/items")

    within("#item-1") do

      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Disable #{@item_5.name}")
    end

  end
end
