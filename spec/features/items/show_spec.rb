require 'rails_helper'

RSpec.describe "items edit page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
  end

  it 'shows a flash message stating information was updated' do
    visit edit_item_path(@item_1)
    fill_in 'Name', with: @item_1.name
    fill_in 'Description', with: @item_1.description
    fill_in :unit_price, with: @item_1.unit_price
    click_button 'Submit'
    expect(page).to have_content("Item information has been successfully updated")
  end
end
