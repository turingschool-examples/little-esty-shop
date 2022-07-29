require 'rails_helper'

RSpec.describe "merchant items show page", type: :feature do
  it "shows item attributes" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

    visit merchant_item_path(merchant_1, item_1)

    expect(page).to have_content("Schroeder-Jerde")
    expect(page).to have_content("Watch")
    expect(page).to have_content("Always a need to tell time")
    expect(page).to have_content("Current Price: $3000")
    expect(page).to_not have_content("Current Price: $4000")
    expect(page).to_not have_content("Klein, Rempel and Jones")
    expect(page).to_not have_content("Crocs")
    expect(page).to_not have_content("Worst and Best Shoes")
  end

  it "can link to merchant items edit page" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

    visit merchant_item_path(merchant_1, item_1)

    expect(page).to have_link("Update Item")
    click_link "Update Item"
    expect(current_path).to eq(edit_merchant_item_path(merchant_1, item_1))
   end

end