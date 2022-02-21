require 'rails_helper'

RSpec.describe 'Merchant item update', type: :feature do
  before do
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant, name: "old name", description: "old description")
    @item2 = create(:item, merchant: @merchant)
  end

  it 'links to item update from item show page' do
    visit "/merchants/#{@merchant.id}/items/#{@item1.id}"

    click_link "Update item"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}/edit")
  end

  it 'has a form to update the item' do
    visit "/merchants/#{@merchant.id}/items/#{@item1.id}/edit"

    expect(page).to have_field('Item name', with: 'old name')
    expect(page).to have_field('Description', with: 'old description')

    fill_in 'Item name', with: 'new name'
    fill_in 'Description', with: 'new description'
    click_button 'Update item'

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item1.id}")
    expect(page).to have_content('new name')
    expect(page).to have_content('new description')
    expect(page).to have_content('Item successfully updated!')
  end
end
