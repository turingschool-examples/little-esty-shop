require 'rails_helper'

RSpec.describe 'the new items form page' do 
  before(:each) do 
    @merchant = create(:merchant)
    
    visit new_merchant_item_path(@merchant)
  end 

  it 'can create a new merchant item' do 
    fill_in "Name", with: "Cool new item"
    fill_in "Description", with: "Super cool"
    fill_in "Unit price", with: 500056

    click_button "Create Item"

    expect(current_path).to eq(merchant_items_path(@merchant))
    expect(page).to have_content("Cool new item")
  end 

  it 'will raise an error if invalid data is entered' do
    click_button "Create Item"
    
    expect(page).to have_content("Please enter valid data")
    expect(current_path).to eq(new_merchant_item_path(@merchant))
  end
end