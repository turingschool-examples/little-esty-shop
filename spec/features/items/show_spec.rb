require 'rails_helper'

RSpec.describe 'the merchant item show page', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "CCC")
    @item1 = @merchant1.items.create!(name: "it1", description: "thing", unit_price: 10, able: "Disabled")
  end

  it 'has item name, description, price' do
    visit "/items/#{@item1.id}"

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content(@item1.unit_price)
  end

  it 'has a link to update the item attributes' do
    visit "/items/#{@item1.id}"

    expect(page).to have_link("Edit Item")
    # click_link "Edit Item"
    # expect(current_path).to eq("/merchants/#{@merchant1.id}/edit")
  end
end
