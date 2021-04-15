require 'rails_helper'

RSpec.describe "Merchant item index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ice Cream Parlour')
    @merchant_2 = Merchant.create!(name: 'Ice Cream Parlour')
    @item_1 = @merchant_1.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: 'Back scratch', description: 'skirtch back', unit_price: 5)
    @item_3 = @merchant_2.items.create!(name: 'Pooper Scooper', description: 'holds doge poo', unit_price: 13)
    visit "/merchant/#{@merchant_1.id}/items"
  end

  it 'can see a list of the names of all items' do
    expect(page).to have_content("My Items")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
    expect(page).to have_link(@item_1.name)
    expect(page).to have_link(@item_2.name)
  end
end
