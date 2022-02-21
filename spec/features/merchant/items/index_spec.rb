require 'rails_helper'

RSpec.describe 'Merchants Index' do

  before :each do
    @merchant_1 = Merchant.create!(name: "Ana Maria")
    @merchant_2 = Merchant.create!(name: "Juan Lopez")
    @merchant_3 = Merchant.create!(name: "Jamie Fergerson")
    @item_1 = @merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
    @item_2 = @merchant_1.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
    @item_3 = @merchant_2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
    @item_4 = @merchant_2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, item_status: 1)
    @item_5 = @merchant_2.items.create!(name: "ring", description: "lotus ring", unit_price: 2345)
    @item_6 = @merchant_3.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, item_status: 1)
    @item_7 = @merchant_3.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
    @item_8 = @merchant_3.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)

  end

  # it 'can see a list of the names of all of the items' do
  #   visit "/merchants/#{@merchant_1.id}/items"
  #
  #   within("#item-0") do
  #
  #   expect(page).to have_content(@item_1.name)
  #   expect(page).to have_content(@item_1.description)
  #   expect(page).to have_content(@item_1.display_price)
  #   expect(page).to_not have_content(@item_2.name)
  #   end
  # end

  # it 'can see an enable/ disable button next to each item' do
  #   visit "/merchants/#{@merchant_2.id}/items"
  #
  #   within("#item-0") do
  #
  #     expect(page).to have_content(@item_3.name)
  #     expect(page).to have_content(@item_3.description)
  #     expect(page).to have_content(@item_3.display_price)
  #     expect(page).to have_button("Enable #{@item_3.name}")
  #
  #   end
  #
  #   within("#item-1") do
  #     expect(page).to have_content(@item_4.name)
  #     expect(page).to have_content(@item_4.description)
  #     expect(page).to have_content(@item_4.display_price)
  #     expect(page).to have_button("Disable #{@item_4.name}")
  #
  #   end
  #
  #   within("#item-2") do
  #     expect(page).to have_content(@item_5.name)
  #     expect(page).to have_content(@item_5.description)
  #     expect(page).to have_content(@item_5.display_price)
  #     expect(page).to have_button("Enable #{@item_5.name}")
  #
  #   end
  #
  #   click_button "Enable #{@item_5.name}"
  #
  #     within("#item-2") do
  #
  #     expect(page).to have_content(@item_5.name)
  #     expect(page).to have_content(@item_5.description)
  #     expect(page).to have_content(@item_5.display_price)
  #     expect(page).to have_button("Disable #{@item_5.name}")
  #   end
  #
  # end

  it 'has 2 sections one Enabled, 1 Disabled' do
    visit "/merchants/#{@merchant_2.id}/items"

    within("#enabled_items-0") do
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.description)
      expect(page).to have_content(@item_4.display_price)
      expect(page).to have_button("Disable #{@item_4.name}")

    end

      within("#disabled_items-0") do

      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content(@item_3.display_price)
      expect(page).to have_button("Enable #{@item_3.name}")

    end

      within("#disabled_items-1") do
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_5.description)
      expect(page).to have_content(@item_5.display_price)
      expect(page).to have_button("Enable #{@item_5.name}")

    end

    # click_button "Enable #{@item_5.name}"
    #
    #   within("#item-2") do
    #
    #   expect(page).to have_content(@item_5.name)
    #   expect(page).to have_content(@item_5.description)
    #   expect(page).to have_content(@item_5.display_price)
    #   expect(page).to have_button("Disable #{@item_5.name}")
    # end

  end
end
