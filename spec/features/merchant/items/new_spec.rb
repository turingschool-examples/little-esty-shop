require 'rails_helper'

RSpec.describe 'Create new item' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Ana Maria')
    @merchant_2 = Merchant.create!(name: 'Juan Lopez')
    @merchant_3 = Merchant.create!(name: 'Jamie Fergerson')
    @item_1 = @merchant_1.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400,
                                        item_status: 1)
    @item_2 = @merchant_1.items.create!(name: 'onion', description: 'red onion', unit_price: 3450, item_status: 1)
    @item_3 = @merchant_1.items.create!(name: 'earing', description: 'Lotus earings', unit_price: 14_500)
    @item_4 = @merchant_2.items.create!(name: 'bracelet', description: 'Silver bracelet', unit_price: 76_000,
                                        item_status: 1)
    @item_5 = @merchant_2.items.create!(name: 'ring', description: 'lotus ring', unit_price: 2345)
    @item_6 = @merchant_3.items.create!(name: 'skirt', description: 'Hoop skirt', unit_price: 2175, item_status: 1)
    @item_7 = @merchant_3.items.create!(name: 'shirt', description: "Mike's Yellow Shirt", unit_price: 5405,
                                        item_status: 1)
    @item_8 = @merchant_3.items.create!(name: 'socks', description: 'Cat Socks', unit_price: 934)
  end
  it 'can see item just created displayed in list of items' do
    visit merchant_items_path(@merchant_1.id)
    expect(page).to have_link('Create New Item')

    click_link 'Create New Item'

    expect(current_path).to eq(new_merchant_item_path(@merchant_1.id))

    fill_in 'Name', with: 'bananas'
    fill_in 'Description', with: 'ripe bananas'
    fill_in 'Unit price', with: 75

    click_button 'Submit'

    banana = Item.last

    expect(current_path).to eq(merchant_items_path(@merchant_1))

    within('#disabled_items-1') do
      expect(page).to have_content(banana.name)
      expect(page).to have_content(banana.description)
      expect(page).to have_content(banana.display_price)
      expect(page).to have_button("Enable #{banana.name}")
    end
  end
end
