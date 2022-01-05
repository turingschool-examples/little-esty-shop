require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do

  it 'list all the names of items for the specific merchant' do
    merchant1 = Merchant.create!(name: 'merchant1')
    merchant2 = Merchant.create!(name: 'merchant2')
    item1 = merchant1.items.create!(name: 'item1', description: 'coolest item ever1', unit_price: 10000)
    item2 = merchant1.items.create!(name: 'item2', description: 'coolest item ever2', unit_price: 20000)
    item3 = merchant1.items.create!(name: 'item3', description: 'coolest item ever3', unit_price: 30000)
    item4 = merchant2.items.create!(name: 'item4', description: 'coolest item ever4', unit_price: 40000)

    visit merchant_items_path(merchant1)

    within ".merchant" do
      expect(page).to have_content("#{merchant1.name}'s Items")
      expect(page).to have_content("#{item1.name}")
      expect(page).to have_content("#{item2.name}")
      expect(page).to have_content("#{item3.name}")
      expect(page).to_not have_content("#{item4.name}")
    end
  end
end
