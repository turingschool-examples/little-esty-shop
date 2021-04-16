require 'rails_helper'

RSpec.describe 'as a merchant, when I visit the merchant items index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)

    visit "merchants/#{@merchant_1.id}/items"
  end

  it "I see my name" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it "shows the names of the merchant's items" do
    within "#item-#{@item_1.id}" do
      expect(page).to have_content(@item_1.name)
    end
    within "#item-#{@item_2.id}" do
      expect(page).to have_content(@item_2.name)
    end
    within "#item-#{@item_3.id}" do
      expect(page).to have_content(@item_3.name)
    end

    expect(page).to_not have_content(@item_4.name)
    expect(page).to_not have_content(@item_5.name)
    expect(page).to_not have_content(@item_6.name)
  end

  it "" do
  end
end
