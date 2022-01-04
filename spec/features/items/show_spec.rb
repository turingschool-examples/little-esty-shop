require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant Name')
    @item_1 = Item.create!(name: 'Couch', description: 'comfy couch', unit_price: '1000', merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Phone', description: 'its cool', unit_price: '500', merchant_id: @merchant_1.id)
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
  end

  it 'lists attributes of the item' do
    expect(page).to have_content("Couch")
    expect(page).to have_content("comfy couch")
    expect(page).to have_content("1000 cents")
  end

  it 'takes me to correct path when clicked Edit Item' do
    click_link("Edit Item")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  end

end
