require 'rails_helper'

RSpec.describe 'merchant item show' do

  it 'has link to update the item information' do

    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)
    item1 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item1 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items/#{item1.id}"

    expect(current_path).to eq("/merchants/#{merch1.id}/items/#{item1.id}")

  end

end