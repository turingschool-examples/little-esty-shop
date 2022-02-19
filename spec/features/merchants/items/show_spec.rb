require 'rails_helper'

# Merchant Items Show Page
#
# As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:
#
# - Name
# - Description
# - Current Selling Price
RSpec.describe 'Merchants Show page' do
  it 'can see all of the items attributes including description, name and price' do
    merchant_1 = Merchant.create!(name: "Ana Maria")
    merchant_2 = Merchant.create!(name: "Juan Lopez")
    item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2400)
    item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 3400)

    visit "/merchants/#{merchant_1.id}/items"

    click_link "cheese"

    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content(item_1.display_price)
  end

#   Merchant Item Update
#
# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

  it 'can see all of the items attributes including description, name and price' do
    merchant_1 = Merchant.create!(name: "Ana Maria")
    merchant_2 = Merchant.create!(name: "Juan Lopez")
    item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2400)
    item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 3400)

    visit "/merchants/#{merchant_2.id}/items/#{item_2.id}"

    expect(page).to have_link("Update #{item_2.name}")

    click_link "Update #{item_2.name}"

    expect(current_path).to eq("/merchants/#{merchant_2.id}/items/#{item_2.id}/edit")

    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_2.description)
    expect(page).to have_content(item_2.display_price)

    expect(find('form')).to have_content('name')
    expect(find('form')).to have_content('description')
    expect(find('form')).to have_content('unit_price')

    fill_in "unit_price", with: "2567"

    click_button "Submit"

    expect(current_path).to eq("/merchants/#{merchant_2.id}/items/#{item_2.id}")

    expect(page).to have_content("#{item.name} has been updated")
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_2.description)
    expect(page).to have_content(item_2.display_price)
    expect(page).to have_content("$25.67")

  end
end
