require 'rails_helper'

RSpec.describe "item create page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "Tamagotchi", description: "Super annoying", unit_price: 800, merchant_id: @merchant_1.id, status: 1)
  end

  describe 'create a new item' do
    it 'has a link to create a new item' do
      visit "/merchants/#{@merchant_1.id}/items"

      within('#new_item') do
        expect(page).to have_content('Create new item')
      end

      click_link 'Create new item'

      expect(current_path).to eq "/merchants/#{@merchant_1.id}/items/new"
    end

    it 'takes me to a new page to create an item' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      expect(page).to have_content('Name:')
      expect(page).to have_field(:name)
      expect(page).to have_content('Description:')
      expect(page).to have_field(:description)
      expect(page).to have_content('Unit price:')
      expect(page).to have_field(:unit_price)
      expect(page).to have_button('Submit')
      
    end
  end

  it 'takes me back to the index page after clicking submit showing my new item has been created' do
    visit "/merchants/#{@merchant_1.id}/items/new"

    fill_in(:name, with: 'Magic 8 Ball')
    fill_in(:description, with: 'Fortune telling')
    fill_in(:unit_price, with: 150)
    click_button('Submit')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_link('Magic 8 Ball')
    expect(page).to have_content('Status: disabled')
  end

  it 'returns an error if content is missing from the form and redirects back to new page again' do
    visit "/merchants/#{@merchant_1.id}/items/new"

    click_button('Submit')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
    expect(page).to have_content('Required content missing')
  end
end