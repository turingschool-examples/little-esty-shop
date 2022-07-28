require 'rails_helper'

RSpec.describe 'merchant item new page' do

  it 'has form for entering item information, and when "submit" is clicked,return to merchant/item/index and see new item with status of disabled' do

    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items/new"

    fill_in "Item Name", with: "A Cool Test Item"
    fill_in "Item Description", with: "Here is the description"
    fill_in "Unit Price", with: 54321

    click_on "Submit"

    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    within "#disabled-items" do
      expect(page).to have_content("A Cool Test Item")
    end

  end

  it 'redirects back to merchant/item/new if form entry not valid' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items/new"

    fill_in "Item Name", with: "A Cool Test Item"
    # fill_in "Item Description", with: "Here is the description"
    fill_in "Unit Price", with: 54321

    click_on "Submit"

    expect(current_path).to eq("/merchants/#{merch1.id}/items/new")

    expect(page).to have_content("Error - please complete all fields")

  end

end