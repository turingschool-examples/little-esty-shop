require 'rails_helper'

RSpec.describe "merchant's item index page" do 
  before(:each) do 
    @merchant = create(:merchant)
    @item1 = create :item, { merchant_id: @merchant.id }

    visit merchant_item_path(@merchant, @item1)
  end

  it 'shows all attributes of the item' do
    expect(current_path).to eq(merchant_item_path(@merchant, @item1))

    expect(page).to have_content(@item1.name) 
    expect(page).to have_content(@item1.description) 
    expect(page).to have_content(@item1.unit_price/100) 
  end 
end 