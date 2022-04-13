require 'rails_helper'

RSpec.describe "Merchant items Show page" do
  before do
    @starw = Merchant.create!(name: "Star Wars R Us ")
    @start = Merchant.create!(name: "Star Trek R Us ")

    @item1 = @starw.items.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 0
                         )

    @item2 = @starw.items.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0
                         )

    visit "/merchants/#{@starw.id}/items/#{@item1.id}"
  end

  it "Displays an item's Attributes" do

    expect(page).to have_content(@item1.name)
    expect(page).to_not have_content(@item2.name)

  end

  it "has an edit button for the item" do

    click_button("Edit #{@item1.name}")
    expect(current_path).to eq(edit_merchant_item_path(@starw,@item1))

    visit merchant_item_path(@starw,@item2)

    click_button("Edit #{@item2.name}")
    expect(current_path).to eq(edit_merchant_item_path(@starw,@item2))

  end
end
