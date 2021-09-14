require 'rails_helper'

RSpec.describe 'merchants items index page' do
  before :each do
    @merchant = Merchant.create!(name: "Steve")
    @merchant_2 = Merchant.create!(name: "Kevin")
    @item_1 = @merchant.items.create!(name: "Lamp", description: "Sheds light", unit_price: 5)
    @item_2 = @merchant.items.create!(name: "Toy", description: "Played with", unit_price: 10)
    @item_3 = @merchant.items.create!(name: "Chair", description: "Sit on it", unit_price: 50)
    @item_4 = @merchant_2.items.create!(name: "Table", description: "Eat on it", unit_price: 100)
  end

  it 'displays merchant item names' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
  end
end
