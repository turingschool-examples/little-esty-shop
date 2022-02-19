require 'rails_helper'

# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant

RSpec.describe 'Merchants Index' do
  it 'can see a list of the names of all of the items' do
    merchant_1 = Merchant.create!(name: "Ana Maria")
    merchant_2 = Merchant.create!(name: "Juan Lopez")
    item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 24)
    item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 34)

    visit "/merchants/#{merchant_1.id}/items"


    expect(page).to have_content(item_1.name)
    expect(page).to_not have_content(item_2.name)

  end
end
