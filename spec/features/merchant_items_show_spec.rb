require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Roald')

    @item_1 = @merchant_1.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 100)
    @item_2 = @merchant_1.items.create!(name: 'Funyuns', description: 'Also Delicious', unit_price: 125)
    @item_3 = @merchant_1.items.create!(name: 'Mountain Dew', description: 'Equally Delicious', unit_price: 200)
    @item_4 = @merchant_1.items.create!(name: 'Fritos', description: 'Meh', unit_price: 105)
  end

  it 'Shows all of the given items attributes' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
    expect(page).to_not have_content(@item_2.name)
  end

# I see a flash message stating that the information has been successfully updated.

  it 'has a link to update item information' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
    expect(page).to have_link('Update Doritos')
  end

  it 'has an edit form' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_on 'Update Doritos'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")

    expect(page).to have_content('Name')
    expect(page).to have_content('Description')
    expect(page).to have_content('Current Selling Price')
  end

  xit 'has information pre-populated' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_on 'Update Doritos'

    expect(page).to have_content('Doritos')
    expect(page).to have_content('Delicious')
    expect(page).to have_content(100)
  end

  it 'updates information' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_on 'Update Doritos'

    fill_in :name, with: 'Doritos'
    fill_in :description, with: 'Delicious'
    fill_in :unit_price, with: 100

    click_on 'Submit'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    expect(page).to have_content(100)
  end

  it 'shows a flash message denoting what has been updated' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_on 'Update Doritos'

    fill_in :name, with: 'Tostitos'

    click_on 'Submit'

    expect(page).to have_content('Successfully updated')
  end
end
