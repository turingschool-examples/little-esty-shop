require 'rails_helper'

RSpec.describe 'Merchant item creation', type: :feature do
  before do
    @merchant1 = create(:merchant)
  end

  it 'has a link to item creation page from merchant items index' do
    visit "/merchants/#{@merchant1.id}/items"
    click_button "Create item"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
  end

  it 'page has a form to fill item information' do
    visit "/merchants/#{@merchant1.id}/items/new"

    fill_in "Item name", with: "Hairbrush"
    fill_in "Description", with: "Smooths your hair"
    fill_in "Unit price", with: 5
    click_button "Save"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    expect(page).to have_content("Hairbrush")
  end

  it 'invalid data entry' do
    visit "/merchants/#{@merchant1.id}/items/new"

    fill_in "Description", with: "this will not work :)"
    click_button "Save"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/items/new")
    expect(page).to have_content("Error: Name can't be blank, Unit price can't be blank")
  end
end
