require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do

  it 'shows a list of the names of all of my items and no other merchants items' do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland")
    item3 = create(:item, name: "Eric")

    visit "/merchants/#{merchant.id}/items"
    expect(page).to have_content("Paul")
    expect(page).to have_content("Leland")
    expect(page).to_not have_content('Eric')
  end

  it "Has buttons next to each item to enable or disable. Both buttons refresh the page with updated status" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant, name: "Paul")
    item2 = create(:item, merchant: merchant, name: "Leland")
    visit "/merchants/#{merchant.id}/items"
    #
    # expect(item1.status).to eq("Disabled")
    # click_button "Enable #{item1.name}"
    # expect(item1.status).to eq("Enabled")

    within("div.item_#{item1.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      click_button("Disable")
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      item1.reload
      expect(item1.status).to eq("Disabled")
    end

    visit "/merchants/#{merchant.id}/items"
    within("div.item_#{item2.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")

      click_button("Enable")
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      item2.reload
      expect(item2.status).to eq("Enabled")
    end
  end

  it "has a link to create a new item" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/items"

    click_link("Create New Item")

    expect(current_path).to eq("/merchants/#{merchant.id}/items/new")
  end

  it "has two sections, one for enabled items, and one for disabled items" do
    visit "/merchants/#{item1.merchant_id}/items"

    expect(page).to have_content("Enabled Items:")
    expect(page).to have_content("Disabled Items:")
    #Not sure what this means so I am just going to add this ^ to the view for now
  end
end
