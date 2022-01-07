require 'rails_helper'

RSpec.describe 'merchant item index page' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item = FactoryBot.create(:item, merchant: @merchant)
    @item2 = FactoryBot.create(:item, merchant: @merchant)
    visit "/merchants/#{@merchant.id}/items"
  end

  it 'shows each item name' do
    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item2.name)
  end

  it 'the item name is a link to the merchant items show page' do
    click_link("#{@item1.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}")
  end
end
