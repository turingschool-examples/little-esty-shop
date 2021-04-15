require 'rails_helper'

RSpec.describe 'merchant items index page' do
  it 'shows a list of the names of all of my items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant2.id)

    visit "/merchants/#{merchant1.id}/items"

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).not_to have_content(item3.name)
  end
end
