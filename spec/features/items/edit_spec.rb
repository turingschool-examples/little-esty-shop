require 'rails_helper'

RSpec.describe 'Item edit page' do

  it 'edits an item' do
    merchant = Merchant.create!(name: "John")
    item = merchant.items.create!(name: "Shirt", description: "A blue shirt", unit_price: 30)

    visit edit_merchant_item_path(merchant, item)
    fill_in "Name", with: "Blue Shirt"
    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(merchant, item))
    expect(page).to have_content("Blue Shirt")
    expect(page).to have_content("Item has been successfully updated")
  end
end
