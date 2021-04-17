require 'rails_helper'

RSpec.describe 'as a merchant, when I click on the name of an item' do
  before(:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)

    visit "merchants/#{@merchant_1.id}/items/"

    click_on("#{@item_1.name}")
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
  end

  it "I am taken to that merchant's item's show page and I see all of the item's attributes" do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.formatted_unit_price)

    expect(page).to_not have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end
end
