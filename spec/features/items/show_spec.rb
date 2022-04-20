require "rails_helper"

RSpec.describe "Item show page" do
  before :each do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
    )
  end

  it "has a list of the items attributes", :vcr do
    visit "/merchants/#{@merchant_1.id}/items/#{@cup.id}"
    expect(page).to have_content("Cup")
    expect(page).to have_content("What the **** is this thing?")
    expect(page).to have_content("100")
  end

  it "has edit button", :vcr do
    visit "/merchants/#{@merchant_1.id}/items/#{@cup.id}"
    expect(page).to have_link("Edit")
    click_on("Edit")
    expect(current_path).to eq("/items/#{@cup.id}/edit")
  end
end
