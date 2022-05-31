require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do

  it "all of an item's attributes" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    item_1 = merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107)
    item_2 = merchant_1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076)

    merchant_2 = Merchant.create!(name: "Willms and Sons")
    item_3 = merchant_2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723)

    visit "/merchants/#{merchant_1.id}/items"
    expect(page).to have_link(item_1.name)

    click_link "#{item_1.name}"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")

    expect(page).to have_content("Name:")
    expect(page).to have_content(item_1.name)
    expect("Name: ").to appear_before("Qui Esse")
    expect(page).to have_content("Description:")
    expect(page).to have_content(item_1.description)
    expect("Description: ").to appear_before("Nihil autem sit odio inventore deleniti")
    expect(page).to have_content("Current Selling Price:")
    expect(page).to have_content(item_1.unit_price)
    expect("Current Selling Price: ").to appear_before("$75107")

    expect(page).to_not have_content(item_2.name)
    expect(page).to_not have_content(item_3.name)
  end
end
