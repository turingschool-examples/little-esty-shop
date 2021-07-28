require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item)

    visit merchant_items_path(@merchant)
  end

  it 'see a list of the names of merchant items' do
    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end
end
