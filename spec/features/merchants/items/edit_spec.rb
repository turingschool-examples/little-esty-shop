require 'rails_helper'

RSpec.describe 'merchant items edit page' do

  it 'exists' do

    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items/#{item1.id}/edit"

    expect(current_path).to eq("/merchants/#{merch1.id}/items/#{item1.id}/edit")

  end

end