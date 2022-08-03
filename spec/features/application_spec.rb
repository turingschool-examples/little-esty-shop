require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'shows the welcome page' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = merchant1.items.create!(name: 'Fake Item 1', description: 'wow', unit_price: 4)
    item2 = merchant1.items.create!(name: 'Another thing', description: 'omg', unit_price: 3)
    item3 = merchant2.items.create!(name: 'Faux stuff', description: 'amazing', unit_price: 2)

    visit '/'

    expect(current_path).to eq('/')
  end

  it 'has a links to merchants and items' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = merchant1.items.create!(name: 'Fake Item 1', description: 'wow', unit_price: 4)
    item2 = merchant1.items.create!(name: 'Another thing', description: 'omg', unit_price: 3)
    item3 = merchant2.items.create!(name: 'Faux stuff', description: 'amazing', unit_price: 2)

    visit '/'

    expect(page).to have_link("Merchants")
    expect(page).to have_link("Items")

    # click_link("Merchants")
    #
    # expect(current_path).to eq('/merchants')
  end
end
