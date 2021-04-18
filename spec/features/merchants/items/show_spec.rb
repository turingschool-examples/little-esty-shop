require 'rails_helper'

RSpec.describe 'merchant items show page' do
  it 'shows all of the items attributes' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant2.id, description: "I am a random description")

    visit "/merchants/#{merchant1.id}/items"

    click_on "#{item1.name}"

    expect(page).to have_current_path("/merchants/#{merchant1.id}/items/#{item1.id}")

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.unit_price)
    expect(page).not_to have_content(item2.name)
    expect(page).not_to have_content(item3.description)
  end
end
