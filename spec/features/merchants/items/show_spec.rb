require 'rails_helper'

RSpec.describe "merchant items show page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create(name: "Schroeder-Jerde" )
    @merchant_2 = Merchant.create(name: "Klein, Rempel and Jones")
    @item_1 = @merchant_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merchant_2.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)

  end
  it "shows item attributes" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    expect(page).to have_content("Schroeder-Jerde")
    expect(page).to have_content("Two-Leg Pantaloons")
    expect(page).to have_content("pants built for people with two legs")
    expect(page).to have_content("Current Price: $50.00")
    expect(page).to_not have_content("Current Price: $30.00")
    expect(page).to_not have_content("Klein, Rempel and Jones")
    expect(page).to_not have_content("Two-Leg Shorts")
    expect(page).to_not have_content("shorts built for people with two legs")
  end

   it "can link to merchant items edit page" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    expect(page).to have_link("Update Item")
    click_link "Update Item"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  end

end
