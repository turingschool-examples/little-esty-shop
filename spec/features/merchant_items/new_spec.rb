require 'rails_helper'

RSpec.describe 'New Form for a merchant item' do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant Name')
    @item_1 = Item.create!(name: 'Couch', description: 'comfy couch', unit_price: '1000', merchant_id: @merchant_1.id, status: 'disabled')
    @item_2 = Item.create!(name: 'Phone', description: 'its cool', unit_price: '500', merchant_id: @merchant_1.id, status: 'enabled')
    visit "/merchants/#{@merchant_1.id}/items/new"
  end

  it 'adds a new item' do
    fill_in(:name, with: 'Plant')
    fill_in(:description, with: 'gloriously green')
    fill_in(:unit_price, with: '5')
    click_button("Create Item")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_content("Plant (disabled)")
  end

end
