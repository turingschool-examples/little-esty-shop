require 'rails_helper'

RSpec.describe 'merchants item show page' do
  it 'shows all of the items attributes' do

    visit '/merchants/1/items/10'

    item = Item.find(10)
    expect(page).to have_content(item.name)
    expect(page).to have_content("Description: #{item.description}")
    expect(page).to have_content("Current Price: $#{item.unit_price.to_f / 100}")
  end

  it 'has a link to update the item' do
    visit '/merchants/1/items/10'

    expect(page).to have_link('Update Item', href: '/merchants/1/items/10/edit')
  end
end
