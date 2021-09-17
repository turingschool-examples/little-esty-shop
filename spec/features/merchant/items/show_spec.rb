require 'rails_helper'

RSpec.describe "merchant items show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
  end

  it "links to merchant item's show page" do

    visit merchant_items_path(@merchant_1)

    click_link(@item_1.name)
    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end
#
#   As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

  it 'shows a link to update item information' do
    visit merchant_item_path(@merchant_1, @item_1)

    expect(page).to have_content("Update Item")
    click_link "Update Item"
    expect(current_path).to eq(edit_item_path(@item_1))
  end
end
