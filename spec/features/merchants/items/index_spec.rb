require 'rails_helper'

RSpec.describe 'merchant items index' do
  it 'has the name of all the merchants items' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)
    item1 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item1 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items"
    expect(current_path).to eq("/merchants/#{merch1.id}/items")
    within('#items') do
      expect(page).to have_content('Shoe')
      expect(page).to have_content('Sock')
      expect(page).to_not have_content('Jerky')
    end
  end
end