require 'rails_helper'

RSpec.describe 'Merchant Item Show Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    @item = create(:item, merchant: @merchant)
    visit merchant_items_path(@merchant, @item)
  end

  it 'click link to merchant item index page and see item and all attributes' do
    visit merchant_items_path(@merchant)
    click_link("#{@item.name}")

    expect(current_path).to eq(merchant_item_path(@merchant, @item))

    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
    expect(page).to have_content('Update Item')
  end
end
