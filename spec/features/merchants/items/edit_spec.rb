require 'rails_helper'

RSpec.describe "merchant's item edit page" do 
  before(:each) do 
    @merchant = create(:merchant)
    @item1 = create :item, { merchant_id: @merchant.id }

    visit edit_merchant_item_path(@merchant, @item1)
  end

  it 'has a form to update the item' do
    fill_in :name, with: "Item1"
    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(@merchant, @item1))
    expect(page).to have_content("Item1")
    expect(page).to have_content("Item has been successfully updated")
  end 

  it 'form handles incorrect submission' do
    fill_in :name, with: ""
    click_button "Submit"

    expect(current_path).to eq(edit_merchant_item_path(@merchant, @item1))
    expect(page).to have_content("Please enter valid data")
  end 
end 