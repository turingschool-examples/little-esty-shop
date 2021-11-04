require 'rails_helper'

RSpec.describe "merchant's item index page" do 
  before(:each) do 
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = create :item, { merchant_id: @merchant.id }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant.id }
    @item4 = create :item, { merchant_id: @merchant2.id }

    visit merchant_items_path(@merchant)
  end

  it 'i see a list of names of all items' do 
    expect(current_path).to eq(merchant_items_path(@merchant))

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).not_to have_content(@item4.name)
  end 
end 