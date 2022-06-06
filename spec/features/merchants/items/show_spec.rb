require 'rails_helper'

RSpec.describe 'merchants items index' do

  it 'shows the attrs of a given item belonging to a merchant' do

    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    item3 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    merch2 = Merchant.create!(name: 'Goopy Gopperations')
    item4 = merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
    item5 = merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

    visit "/merchants/#{merch1.id}/items"

    click_link "#{item1.name}"

    expect(page).to have_content("Name: #{item1.name}")
    expect(page).to have_content("Description: #{item1.description}")
    expect(page).to have_content("Current Selling Price: #{item1.unit_price}")
    expect(page).to_not have_content(item2.name)

  end

  it "shows a link to update item information and displays a flash message when successful" do

    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    item3 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    visit "/merchants/#{merch1.id}/items/#{item1.id}"
    click_link "Edit #{item1.name}"
    expect(current_path).to eq("/merchants/#{merch1.id}/items/#{item1.id}/edit")
    fill_in :name, with: 'Floopy New'
    fill_in :description, with: 'New and Improved'
    click_button 'Update Item'
    expect(current_path).to eq("/merchants/#{merch1.id}/items/#{item1.id}")
    expect(page).to have_content("Floopy New")
    expect(page).to have_content("New and Improved")
    expect(page).to have_content("450")
    expect(page).to have_content("Success: Item information has been updated.")
  end

end
