require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  it 'displays the item attributes' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    visit "/merchants/#{merchant1.id}/items"
    # save_and_open_page
    click_on item1.name
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.unit_price)
  end

  it 'allows the merchant to update their items' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    visit "/merchants/#{merchant1.id}/items/#{item1.id}"

    expect(page).to have_content("Update #{item1.name}")
    click_on("Update #{item1.name}")
    expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")

    within("#update_item") do
      fill_in 'unit_price', with: 11111
    end
    click_on 'Submit'
    expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    #checking for flash message
    expect(page).to have_content("Item Succeefully Updated")
  end 
end
