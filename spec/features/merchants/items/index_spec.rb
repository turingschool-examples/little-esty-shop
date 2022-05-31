require 'rails_helper'

RSpec.describe 'merchants items index' do

  it 'shows the name of the items belonging to a merchant' do
    # As a merchant,
    # When I visit my merchant items index page ("merchant/merchant_id/items")
    # I see a list of the names of all of my items
    # And I do not see items for any other merchant
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    item3 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    merch2 = Merchant.create!(name: 'Goopy Gopperations')
    item4 = merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
    item5 = merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

    visit "/merchants/#{merch1.id}/items"

    # save_and_open_page

    expect(page).to have_content(merch1.name)
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
    expect(page).to_not have_content(item4.name)
    expect(page).to_not have_content(item5.name)

  end

  it 'allows me to enable / disable items belonging to a merchant' do
    # As a merchant
    # When I visit my items index page
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed
    merch1 = Merchant.create!(name: 'Floopy Fopperations')
    item1 = merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
    item2 = merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
    item3 = merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

    visit "/merchants/#{merch1.id}/items"

  end
end
