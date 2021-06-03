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

    click_button("Disable #{@item_1.name}")
    
    expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    expect(@item_1.status).to eq("disable")
  end
  #   Merchant Items Grouped by Status
  #
  # As a merchant,
  # When I visit my merchant items index page
  # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
  # And I see that each Item is listed in the appropriate section


end
