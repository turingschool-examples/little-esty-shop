require 'rails_helper'

RSpec.describe 'Merchant Items Edit Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
  end

  describe 'When I visit the merchant show page of an item' do
    it 'I see a link to update the item information.' do
      visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

      expect(page).to have_link('Edit Item')
    end
  end

  it 'Then takes me to a page to edit this item' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

    click_link('Edit Item')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  end

  it 'has a form filled in with the existing item info' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"

    within('#edit_form') do
      expect(page).to have_content('Name:')
      expect(page).to have_field(:item_name)

      expect(page).to have_content('Description:')
      expect(page).to have_field(:item_description)

      expect(page).to have_content('Current price:')
      expect(page).to have_field(:item_unit_price)

      expect(page).to have_button('Submit')
    end
  end

  it 'I am redirected back to the item show page where I see the updated information and I see a flash message.' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"

    fill_in(:item_description, with: "90's Trading cards")

    click_button('Submit')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

    expect(page).to have_content('Item updated')
  end

  xit 'returns an error if content is incorrect' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"
    # fill_in(:item_description, with: '')
    click_button('Submit')
    
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
    expect(page).to have_content('Update invalid')
  end
end