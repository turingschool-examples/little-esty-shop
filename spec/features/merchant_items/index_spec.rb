require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @merchant = Merchant.create!(name: "Angela's Shop")
    @item_1 = @merchant.items.create!(name: "Jade Rabbit", description: "25mmx25mm hand carved jade rabbit", unit_price: 2500)
    @item_2 = @merchant.items.create!(name: "Amazonite Rabbit", description: "25mmx25mm hand carved Amazonite rabbit", unit_price: 3500)
  end

  it 'lists the names of all the items' do

    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

  end

  it 'links to items show page' do

    visit "/merchants/#{@merchant.id}/items"

    within('#item-0') do
      click_link
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    end
  end

  it 'can create a new item' do
    visit "/merchants/#{@merchant.id}/items"

    click_link('Create New Item')

    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")

    fill_in 'name', with: "bob the skull"
    fill_in 'description', with: "a witty skull"
    fill_in 'unit_price', with: "100"

    click_button

    expect(page).to have_content 'bob the skull'
  end

  it 'can enable/disable an item' do
    visit "/merchants/#{@merchant.id}/items"

    within('#disabled-items') do
      expect(page).to_not have_button('Disable')

      within('#item-0') do
        click_on('Enable')
      end
    end

    within('#enabled-items') do
      expect(page).to_not have_button('Enable')

      within('#item-0') do
        click_on('Disable')
      end
    end
  end

  it 'lists the top five items' do
    visit "/merchants/1/items"

    within('#top_five_items') do
      expect('Item Qui Esse; Total Revenue: $20,278.89').to appear_before('Item Ea Voluptatum; Total Revenue: $15,504.48')
      expect(page).to have_content('Item Expedita Aliquam; Total Revenue: $10,308.45')
      expect(page).to have_content('Item Voluptatem Sint; Total Revenue: $8,918.10')
      expect(page).to have_content('Item Provident At; Total Revenue: $7,803.25')
    end
  end
end
