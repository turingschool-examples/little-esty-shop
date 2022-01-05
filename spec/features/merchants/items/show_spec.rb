require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  it 'displays the item attributes' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    visit "/merchants/#{merchant1.id}/items"
    # save_and_open_page
    click_on item1.name
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.unit_price)
  end
end
