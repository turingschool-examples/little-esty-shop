require 'rails_helper'

RSpec.describe 'Merchant Items New Page' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
    @merchant_2 = Merchant.create!(name: 'Cummings-Thiel')
    @item_1 = @merchant_1.items.create!(name: 'tem Qui Esse', description: 'nihil autem', unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: 'Item Autem Minima', description: 'Cumque consequuntu', unit_price: 67076)
    @item_3 = @merchant_2.items.create!(name: 'Item Ea Voluptatum', description: 'Sunt officia', unit_price: 32301)
  end

  it 'has an empty form for a new item' do
   visit "/merchants/#{@merchant_1.id}/items/new"

   fill_in(:name, with: "Quiche")
   fill_in(:description, with: 'Darn Good Quiche')
   fill_in(:unit_price, with: "173")

   click_button('Create Item')

   expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
   expect(page).to have_content("Quiche")
   expect(page).to have_content("Darn Good Quiche")
   expect(page).to have_content("173")

   visit "/merchants/#{@merchant_1.id}/items/new"

   fill_in(:name, with: "Tomato Soup")
   fill_in(:description, with: 'Does not come with grilled cheese')
   fill_in(:unit_price, with: "200")

   click_button('Create Item')

   expect(current_path).to eq("/merchants/#{@merchant_2.id}/items")
   expect(page).to have_content("Tomato Soup")
   expect(page).to have_content("Does not come with grilled cheese")
   expect(page).to have_content("200")
  end
end
