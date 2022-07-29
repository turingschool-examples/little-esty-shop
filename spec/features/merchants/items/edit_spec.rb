require 'rails_helper'

RSpec.describe "merchant items edit page", type: :feature do
  it "shows edit form for item" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

    visit edit_merchant_item_path(merchant_1, item_1)

    expect(page).to have_field("Name", with: 'Watch')
    expect(page).to have_field("Description", with: 'Always a need to tell time')
    expect(page).to have_button("Submit")
  end

  it "can update item" do
    merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
    merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
    item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
    item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

    visit edit_merchant_item_path(merchant_1, item_1)

    fill_in "Name", with: "Monocle"
    fill_in "Description", with: "Timeless"
    fill_in "unit_price", with: 1200
    click_button "Submit"
    expect(current_path).to eq(merchant_item_path(merchant_1, item_1))
    expect(page).to have_content("Item successfully updated!")
    expect(page).to have_content("Monocle")
    expect(page).to have_content("Timeless")
    expect(page).to_not have_content("Watch")
  end

    it "can prevent item from being updated with incorrect information" do
      merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
      merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones", created_at: Time.now, updated_at: Time.now)
      item_1 = Item.create!(name: "Watch", description: "Always a need to tell time", unit_price: 3000, merchant_id: merchant_1.id, created_at: Time.now, updated_at: Time.now)
      item_2 = Item.create!(name: "Crocs", description: "Worst and Best Shoes", unit_price: 4000, merchant_id: merchant_2.id, created_at: Time.now, updated_at: Time.now)

      visit edit_merchant_item_path(merchant_1, item_1)
      fill_in "Name", with: " "
      fill_in "Description", with: " "
      fill_in "unit_price", with: "asdasd"
      click_button "Submit"
      expect(current_path).to eq(edit_merchant_item_path(merchant_1, item_1))
      expect(page).to have_content("Error: Name can't be blank, Description can't be blank")
    end

end