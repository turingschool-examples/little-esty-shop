require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items'" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant2.id)
    @item6 = create(:item, merchant_id: @merchant2.id)
  end

  it 'shows all associated items' do
    visit merchant_items_path(@merchant1)

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to have_content(@item4.name)

    expect(page).not_to have_content(@item5.name)
    expect(page).not_to have_content(@item6.name)
  end

  it "routes to merchant's item show page when item name is clicked" do
    visit merchant_items_path(@merchant1)
    # save_and_open_page

    click_link(@item.name)

    expect(current_path).to eq(merchant_item_path(@merchant1, @item))
  end
end
