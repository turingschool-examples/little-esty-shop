require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items/item_id'" do
  before :each do
      @merchant1 = create(:merchant)
      @item = create(:item, merchant_id: @merchant1.id)
  end

  it "displays name, description and current selling price" do
    visit merchant_item_path(@merchant1, @item)

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
  end

  it "has an update link" do
    visit merchant_item_path(@merchant1, @item)
    click_on "Update Item"

    expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item))
  end
end
