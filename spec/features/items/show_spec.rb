require 'rails_helper'

RSpec.describe 'the merchant item show page', type: :feature do
  it 'has item name, description, price' do
    item = Item.create!(name: "it1", description: "thing", unit_price: 10, status: "Disabled")

    visit "/items/#{item.id}"

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.unit_price)
  end

  it 'has a link to update the item attributes' do
    item = Item.create!(name: "it1", description: "thing", unit_price: 10, status: "Disabled")

    visit "/items/#{item.id}"

    expect(page).to have_link("Edit Item")
    click_link "Edit Item"
    expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")
  end

end
