require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant Name')
    @merchant_2 = Merchant.create!(name: 'BLA BLA')
    @item_1 = Item.create!(name: 'Couch', description: 'comfy couch', unit_price: '1000', merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Phone', description: 'its cool', unit_price: '500', merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Fridge', description: 'it cools food', unit_price: '2000', merchant_id: @merchant_2.id)
    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'lists names of all items for merchant' do
    expect(page).to have_content("Couch")
    expect(page).to have_content("Phone")
  end

  it 'doesnt list items from other merchants' do
    expect(page).to_not have_content("Fridge")
  end

end
