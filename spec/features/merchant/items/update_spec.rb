require 'rails_helper'

RSpec.describe 'Merchant Item update' do
  it 'can update show page with a form for merchant items' do
    merchant_1 = Merchant.create!(name: 'Ana Maria')
    merchant_2 = Merchant.create!(name: 'Juan Lopez')
    item_1 = merchant_1.items.create!(name: 'cheese', description: 'european cheese', unit_price: 2400)
    item_2 = merchant_2.items.create!(name: 'onion', description: 'red onion', unit_price: 3400)

    visit merchant_item_path(merchant_2, item_2)

    expect(page).to have_link("Update #{item_2.name}")

    click_link "Update #{item_2.name}"
    expect(current_path).to eq("/merchants/#{merchant_2.id}/items/#{item_2.id}/edit")

    fill_in 'Unit price', with: '2567'
    click_button 'Submit'

    expect(current_path).to eq("/merchants/#{merchant_2.id}/items/#{item_2.id}")
    expect(page).to have_content("#{item_2.name} has been updated")
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_2.description)

    expect(page).to have_content('$25.67')
  end
end
