require 'rails_helper'

RSpec.describe 'Item Create' do

  it 'will show me a form that will allow me to create a new item and when I click submit it will take me to the items index page where i will see the item i created in the disabled items list' do

    @merchant1 = Merchant.create!(name: "Calvin Klein")

    @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id, status: 1)
    @item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: @merchant1.id, status: 0)
    @item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: @merchant1.id, status: 1)
    @item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: @merchant1.id, status: 0)
    @item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: @merchant1.id, status: 1)
    @item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: @merchant1.id, status: 0)

    visit "/merchants/#{@merchant1.id}/items/new"

    fill_in "Name", with: " "
    fill_in "Description", with: " "
    fill_in "Price", with: "letters"

    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
    expect(page).to have_content("Error: Name can't be blank, Description can't be blank, Unit price is not a number")

    fill_in "Name", with: "Test Item"
    fill_in "Description", with: "Test Description"
    fill_in "Price", with: 125

    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    
    within "#disabled-items" do
      expect(page).to have_content("Test Item")
    end
  end
end