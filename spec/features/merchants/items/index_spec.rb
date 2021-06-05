require 'rails_helper'

RSpec.describe 'merchant items index' do
  before :each do
    @merchant_1 = Merchant.find(1)
    @merchant_2 = Merchant.find(2)
    @item_1 = Item.find(1)
    @item_2 = Item.find(37)
  end

  it 'displays the name of the Merchant and no others' do
    visit "/merchants/#{@merchant_1.id}/items"


    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'lists all of the items names' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to_not have_content(@item_2.name)
  end

  it 'links to item show page' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_on "#{@item_1.name}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
  end

  it 'has a button to create a new item' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_button 'New Item'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
  end

  it 'has button to enable or disable item' do
    visit "/merchants/#{@merchant_1.id}/items"

    within "li#id-1" do
     click_button "Disable"
   end

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(page).to have_content("Disable")
  end
end
