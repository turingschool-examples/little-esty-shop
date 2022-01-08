require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  it 'displays the item attributes' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    visit "/merchants/#{merchant1.id}/items"

    click_on item1.name
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.unit_price)
  end

  it 'allows the merchant to update their items' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1, unit_price: 77777)
    visit "/merchants/#{merchant1.id}/items/#{item1.id}"
    expect(page).to have_link("Update #{item1.name}")
    click_on("Update #{item1.name}")
    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")
    expect(page).to have_field(:item_unit_price, with: 77777)

    within("#update_item") do
      fill_in 'item_unit_price', with: 11111
      click_on 'Update Item'
    end
    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
    #checking for flash message
    expect(page).to have_content("Item Successfully Updated")
  end
end
