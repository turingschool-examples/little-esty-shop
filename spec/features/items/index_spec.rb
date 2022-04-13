require 'rails_helper'

RSpec.describe "Items Index" do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
    @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
  end

  it "has buttons to enable and disable an item" do
    visit "/items"

    within "##{@item_1.id}" do
      expect(page).to have_content("#{@item_1.name}\nStatus: Disabled")
      click_button "Enable"
    end

    expect(current_path).to eq("/items")
    within "##{@item_1.id}" do
      expect(page).to have_content("#{@item_1.name}\nStatus: Enabled")
    end
  end
end
