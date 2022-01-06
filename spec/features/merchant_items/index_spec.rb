require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do

  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Merchant Name')
    @merchant_2 = Merchant.create!(name: 'BLA BLA')
    @item_1 = Item.create!(name: 'Couch', description: 'comfy couch', unit_price: '1000', merchant_id: @merchant_1.id, status: 'disabled')
    @item_2 = Item.create!(name: 'Phone', description: 'its cool', unit_price: '500', merchant_id: @merchant_1.id, status: 'enabled')
    @item_3 = Item.create!(name: 'Fridge', description: 'it cools food', unit_price: '2000', merchant_id: @merchant_2.id, status: 'enabled')
    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'lists names of all items for merchant' do
    expect(page).to have_content("Couch")
    expect(page).to have_content("Phone")
  end

  it 'doesnt list items from other merchants' do
    expect(page).to_not have_content("Fridge")
  end

  it 'can disable or enable item' do
    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'item is disabled by default' do
    expect(page).to have_content('Couch (disabled)')
  end

  it 'can update status of item' do
    click_button("Enable", id: @item_1.id)
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_content('Couch (enabled)')
  end

  it 'displays only enabled items under enabled section and disabled items under disabled section' do

    within "#enabled" do
      expect(page).to have_content("Phone")
      expect(page).to_not have_content("Couch")
    end
    within "#disabled" do
      expect(page).to_not have_content("Phone")
      expect(page).to have_content("Couch")
    end

  end

  it 'When the Create Item link is clicked, it takes you to correct route' do
    click_link("Create Item")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

end
