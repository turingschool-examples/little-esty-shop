require 'rails_helper'

RSpec.describe 'new item page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")

    visit new_merchant_item_path(@merchant)
  end

  it 'has a form to create a new merchant item' do
    expect(page).to have_field(:item_name)
    expect(page).to have_field(:item_description)
    expect(page).to have_field(:item_unit_price)
  end

  it 'creates a new item when submitted' do
    fill_in(:item_name, with: "Nugget")
    fill_in(:item_description, with: "A nugget")
    fill_in(:item_unit_price, with: 45)
    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(@merchant))
    expect(page).to have_content("New item for #{@merchant.name} has been created.")
    expect(page).to have_content("Nugget")
    save_and_open_page
  end
end
