require 'rails_helper'

describe "merchant items show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
  end

  it "can see all the items attributes including name, description, and selling price" do
    visit merchant_item_path(@merchant1, @item_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
    expect(page).to have_no_content(@item_2.name)

    visit merchant_item_path(@merchant1, @item_2)

    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.description)
    expect(page).to have_content(@item_2.unit_price)
    expect(page).to have_no_content(@item_3.name)
  end

  it "has a link to update item info" do
    visit merchant_item_path(@merchant1, @item_1)

    click_link "Update Item"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item_1.id}/edit")
  end
end
