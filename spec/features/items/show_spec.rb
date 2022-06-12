require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do
  before do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")

    @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076)

    @merchant_2 = Merchant.create!(name: "Willms and Sons")

    @item_3 = @merchant_2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723)
  end

  it "all of an item's attributes, including name, description and selling price" do

    visit merchant_item_path(@merchant_1, @item_1)

    expect(page).to have_content("Item: Qui Esse")
    expect(page).to have_content("Description: Nihil autem sit odio inventore deleniti")
    expect(page).to have_content("Current Selling Price: $75,107.00")

    expect(page).to_not have_content("Autem Minima")
    expect(page).to_not have_content("Ea Voluptatum")
  end

  it "has a link to update item info" do
    visit merchant_item_path(@merchant_1, @item_1)

    click_link "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
  end

end
