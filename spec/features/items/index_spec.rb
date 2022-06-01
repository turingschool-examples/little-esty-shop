require 'rails_helper'

RSpec.describe "Merchant Items Index Page" do

  it "displays only a specified merchant's items" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    item_1 = merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti", unit_price: 75107)
    item_2 = merchant_1.items.create!(name: "Autem Minima", description: "Cumque consequuntur ad", unit_price: 67076)

    merchant_2 = Merchant.create!(name: "Willms and Sons")
    item_3 = merchant_2.items.create!(name: "Ea Voluptatum", description: "Sunt officia", unit_price: 68723)

    visit merchant_items_path(merchant_1)

    expect(page).to have_content("Qui Esse")
    expect(page).to have_content("Autem Minima")
    expect(page).to_not have_content("Ea Voluptatum")
  end
end
