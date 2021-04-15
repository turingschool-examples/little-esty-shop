require 'rails_helper'

RSpec.describe 'merchant items edit page' do
  it 'allows to update items information' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)

    visit "/merchants/#{merchant1.id}/items/#{item2.id}"

    click_on "Update Item"

    expect(page).to have_current_path("/merchants/#{merchant1.id}/items/#{item2.id}/edit")

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit price')

    fill_in 'Description', with: 'Best product 2019 as per Mens Magazine'
    fill_in 'Unit price', with: '12095'

    click_button "Update Item"

    expect(page).to have_current_path("/merchants/#{merchant1.id}/items/#{item2.id}")

    expect(page).to have_content(item2.name)
    expect(page).to have_content('Best product 2019 as per Mens Magazine')
    expect(page).to have_content(12095)
  end
end
