require 'rails_helper'

RSpec.describe "Merchant Items New Page" do
  it "displays a form to add a new item, when I submit the item I am redirected to my merchants item index page where the item has been added as disabled" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde")

    expect(new_merchant_item_path(merchant_1)).to_not have_content("Cool New Thingymabob")

    visit new_merchant_item_path(merchant_1)

    fill_in "Name", with: "Cool New Thingymabob"
    fill_in "Description", with: "Exactly the thing you didn't know you needed"
    fill_in "Unit Price", with: "10"
    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(merchant_1))

    within ".disabled-items" do
      expect(page).to have_content("Cool New Thingymabob")
    end

    within ".enabled-items" do
      expect(page).to_not have_content("Cool New Thingymabob")
    end
  end
end
