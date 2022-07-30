require 'rails_helper'

RSpec.describe 'merchant items index' do
  it 'has the name of all the merchants items' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch2.id)

    visit "/merchants/#{merch1.id}/items"
    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    expect(page).to have_content('Shoe')
    expect(page).to have_content('Sock')
    expect(page).to_not have_content('Jerky')
  end

  it 'has a button next to each item name to disable or enable that item. When clicked, user is redirected to item index and sees item status has changed' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id, status: 1)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items"

    within "#enabled-items" do
      expect(page).to have_content("Shoe")
    end

    within "#disabled-items" do
      expect(page).to have_content("Sock")
      expect(page).to have_content("Jerky")
    end

    within "#enabled-item-#{item1.id}" do
      click_on "Disable"
    end

    expect(current_path).to eq("/merchants/#{merch1.id}/items")
    
    within "#disabled-items" do
      expect(page).to have_content("Shoe")
    end
    
    within "#disabled-item-#{item3.id}" do
      click_on "Enable"
    end

    expect(current_path).to eq("/merchants/#{merch1.id}/items")

    within "#enabled-items" do
      expect(page).to have_content("Jerky")
    end
  end

  it 'has link to create a new item, which takes user to a form to add item information' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    merch2 = Merchant.create!(name: 'Molly Fine Arts')

    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id, status: 1)
    item2 = Item.create!(name: 'Sock', description: 'A sock', unit_price:200, merchant_id: merch1.id)
    item3 = Item.create!(name: 'Jerky', description: 'Alligator jerky', unit_price:1500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items"

    click_link "New Item"

    expect(current_path).to eq("/merchants/#{merch1.id}/items/new")
  end

end

