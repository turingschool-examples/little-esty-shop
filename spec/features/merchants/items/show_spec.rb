require 'rails_helper'

RSpec.describe "items show page" do
  before :each do
    @merchant_1 = Merchant.first
    @item_1 = Item.first
  end

  it "displays the item and its attributes" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end

  it "displays the item and its attributes" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_link 'Update Item'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  end
end
