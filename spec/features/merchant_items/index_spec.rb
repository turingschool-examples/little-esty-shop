require 'rails_helper'

RSpec.describe 'Merchant Items Index' do

  #   Merchant Items Index Page
  #
  # As a merchant,
  # When I visit my merchant items index page ("merchants/merchant_id/items")
  # I see a list of the names of all of my items
  # And I do not see items for any other merchant
  it 'Can can visist a merchant index page' do
    merchant = Merchant.create!(name: 'Schroeder-Jerde')
    merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510)
    visit "/merchants/#{merchant.id}/items"
    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content('Schroeder-Jerde')
    expect(page).to have_content('Item Qui Esse')
  end

  #   Merchant Item Disable/Enable
  #
  # As a merchant
  # When I visit my items index page
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  it 'Can can visist a merchant index page' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"
    # binding.pry
    find_button("Disable #{@item_1.name}").click

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_button("Enable #{@item_1.name}")

    @item_1 = Item.find(@item_1.id)

    expect(@item_1.status).to eq("disable")
  end

  #   Merchant Items Grouped by Status
  #
  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section
  it 'Can can visist a merchant index page' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(page).to have_content("Disabled Items")
    expect(page).to have_content("Enabled Items")
  end

  #   Merchant Item Create
  #
  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  it 'Can can visist a merchant index page' do
    @merchant = Merchant.create!(name: 'Schroeder-Jerde')
    @item_1 = @merchant.items.create!(name: 'Item Qui Esse', description: 'description', unit_price: 7510, status: "enable")
    visit "/merchants/#{@merchant.id}/items"

    expect(current_path).to eq("/merchants/#{@merchant.id}/items")

    expect(page).to have_button("Add a New Item")
    click_button("Add a New Item")
    expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
  end

end
