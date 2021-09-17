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

  # Then I am taken to a page to edit this item
  # And I see a form filled in with the existing item attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the item show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.

  it 'has a form with attributes filled in and redirects back to item page' do
    visit edit_item_path(@item_1)
    fill_in 'Name', with: @item_1.name
    fill_in 'Description', with: @item_1.description
    fill_in :unit_price, with: @item_1.unit_price
    click_button 'Submit'

    expect(current_path).to eq(item_path(@item_1))
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end
end
