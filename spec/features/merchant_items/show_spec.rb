require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe 'Merchant Items Show' do
  before :each do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant, unit_price: 2500)
  end

  it 'displays its attributes' do

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content("$25.00")
  end

  it 'can edit the item' do

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"

    within('#update_link') do
      click_link
    end

    fill_in 'Name', with: "Moazinite Rabbit"
    fill_in 'Description', with: "25mmx25mm Moazinite Rabbit"
    fill_in 'Unit price', with: "4500"

    click_button

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    expect(page).to have_content "Moazinite Rabbit"
    expect(page).not_to have_content "Jade Rabbit"
  end

  it 'can edit parts of the item without removing other attributes' do

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"

    within('#update_link') do
      click_link
    end

    fill_in 'Name', with: "Moazinite Rabbit"
    fill_in 'Description', with: "25mmx25mm Moazinite Rabbit"

    click_button

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    expect(page).to have_content "$25.00"
  end
end
