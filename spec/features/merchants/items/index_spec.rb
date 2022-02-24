require 'rails_helper'

RSpec.describe 'merchant item index', type: :feature do
  before do
    @merchant = create(:merchant)

    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
  end

  it 'displays all items' do
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
  end

  it 'has links to each items show page' do
    visit "/merchants/#{@merchant.id}/items"

    within "#item-#{@item2.id}" do
      click_link "View item"
    end

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item2.id}")
  end
end
