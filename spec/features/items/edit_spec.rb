require 'rails_helper'

RSpec.describe 'item item edit', type: :feature do
  it 'shows the item edit form' do
    item = Item.create!(name: "it1", description: "thing", unit_price: 10, status: "Disabled")

    visit "/items/#{item1.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit Price')
    expect(find('form')).to have_content('Status')
    expect(find('form')).to have_button('Submit Edit')
    end
  end

  it 'updates then redirects to item show page, displays flash' do
    item = Item.create!(name: "it1", description: "thing", unit_price: 10, status: "Disabled")

    visit "/items/#{item1.id}/edit"

    fill_in "Name", with: "Change"
    click_button "Submit Edit"
    expect(current_path).to eq("/items/#{item1.id}/")
    expect(page).to have_content("Item was successfully updated.")
  end
end
