require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  item1 = FactoryBot.create(:item)
  item2 = FactoryBot.create(:item)
  item3 = FactoryBot.create(:item)
  it 'shows a list of the names of all of my items and no other merchants items' do
    visit "/merchants/#{item1.merchant_id}/items"
    expect(page).to have_content(item1.name)
    expect(page).to_not have_content(item2.name)
    expect(page).to_not have_content(item3.name)
  end

  it "has a link to create a new item" do
    visit "/merchants/#{item1.merchant_id}/items"

    click_link("Create New Item")

    expect(current_path).to eq("/merchants/#{item1.merchant_id}/items/new")
  end
end
