require 'rails_helper'

RSpec.describe 'merchants item show page' do
  it 'shows all of the items attributes' do
    # require 'pry'; binding.pry
    visit '/merchants/1/items/10'

    save_and_open_page
    item = Item.find(10)
    expect(page).to have_content(item.name)
    expect(page).to have_content("Description: #{item.description}")
    expect(page).to have_content("Current Price: $#{item.unit_price.to_f/100}")
  end
end
