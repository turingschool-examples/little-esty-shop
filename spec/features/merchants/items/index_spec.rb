require 'rails_helper'

RSpec.describe 'merchant items index page' do 
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "One-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
    @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
    @item_4 = @merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 50000)
    @item_5 = @merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 3000000)
    @item_6 = @merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 100)
    @item_6 = @merch_2.items.create!(name: "Pirate Pants", description: "Peg legs don't need pant legs", unit_price: 1000)
   
  end

  it 'displays a list of the names of all the merchants items and none from any other merchant' do
    visit "merchants/#{@merch_1.id}/items"
    expect(page).to have_content("Two-Leg Pantaloons")
    expect(page).to have_content("Two-Leg Shorts")
    expect(page).to have_content("Hat")
    expect(page).to have_content("Double Legged Pant")
    expect(page).to have_content("Stainless Steel, 5-Pocket Jean")
    expect(page).to have_content("String of Numbers")
    expect(page).to_not have_content("Pirate Pants")
  end

  it 'can disable/enable an item and the items are seperated and displayed by status' do
    visit "/merchants/#{@merch_1.id}/items"
    within "#disabled" do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_button("Disable")
        click_button("Enable")
        expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
      end
    end
    within "#enabled" do
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_button("Enable")
        click_button("Disable")
        expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
      end
    end
  end

  it 'has a link to create a new item' do
    visit "/merchants/#{@merch_1.id}/items"
    click_link("New Item")
    expect(current_path).to eq("/merchants/#{@merch_1.id}/items/new")

  end
end