require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe 'merchant items index page' do
# As a merchant,
# When I visit my merchant items index page ("merchant/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
  it 'shows all of the merchants items' do
    merchant_1 = Merchant.create!(FactoryBot.attributes_for(:merchant))
    merchant_2 = Merchant.create!(FactoryBot.attributes_for(:merchant))
    item_1 = merchant_1.items.create!(FactoryBot.attributes_for(:item))
    item_2 = merchant_1.items.create!(FactoryBot.attributes_for(:item))
    item_3 = merchant_1.items.create!(FactoryBot.attributes_for(:item))
    item_4 = merchant_1.items.create!(FactoryBot.attributes_for(:item))
    item_5 = merchant_1.items.create!(FactoryBot.attributes_for(:item))
    item_6 = merchant_2.items.create!(FactoryBot.attributes_for(:item))
    visit "merchant/#{merchant_1.id}/items"
    
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to have_content(item_4.name)
    expect(page).to have_content(item_5.name)
    expect(page).to_not have_content(item_6.name)
  end
end

