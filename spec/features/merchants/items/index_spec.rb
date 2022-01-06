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

    within("div.item_#{item1.id}") do
      expect(page).to have_link("Enable")
      expect(page).to have_link("Disable")

      click_link("Disable")
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      #^not sure if this works from a within block
      expect(item1.status).to eq("Disabled")
    end
    #these tests might need work ^ and also unsure what to test for string/integer with status
    within("div.item_#{item2.id}") do
      expect(page).to have_content("Enable")
      expect(page).to have_content("Disable")

      click_button("Enable")
      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      expect(item2.status).to eq("Enabled")
    end
  end

  it "has a link to create a new item" do
    merchant = create(:merchant)

    visit "/merchants/#{merchant.id}/items"

    click_link("Create New Item")

    expect(current_path).to eq("/merchants/#{merchant.id}/items/new")
  end
end
