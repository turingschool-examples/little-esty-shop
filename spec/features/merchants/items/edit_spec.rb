require 'rails_helper'

RSpec.describe 'merchant items edit page' do

  it 'exists' do

    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items/#{item1.id}/edit"

    expect(current_path).to eq("/merchants/#{merch1.id}/items/#{item1.id}/edit")

  end

  it 'has a form pre-filled with the existing item attribute information' do

    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items/#{item1.id}/edit"

    within "#item-name-field" do
      expect(page).to have_content("Shoe")
    end

    within "#item-description-field" do
      expect(page).to have_content("Just one shoe")
    end

    within "#item-price-field" do
      expect(page).to have_content("$500.00")
    end
    # test is failing but appearing on the save_and_open_page? Requested help in code-help
    # will fix when know more
  end

  it 'when user updates information in the form and clicks submit, they are redirected back to the item show page with the updated information' do
    merch1 = Merchant.create!(name: 'Jolly Roger Imports')
    item1 = Item.create!(name: 'Shoe', description: 'Just one shoe', unit_price:500, merchant_id: merch1.id)

    visit "/merchants/#{merch1.id}/items/#{item1.id}/edit"

    fill_in 'name', with: "Another Shoe"
    fill_in 'description', with: "A perfect match if you only have one shoe"
    fill_in 'price', with: "6000"

    save_and_open_page
  end

end

# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

