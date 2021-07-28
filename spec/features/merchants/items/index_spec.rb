require 'rails_helper'

RSpec.describe 'Merchants Items Index page' do
  before(:each) do

    @merchant_1 = create(:merchant)
    4.times do
      @items = create(:item, merchant_id: @merchant_1.id)
    end

    visit "/merchants/#{@merchant_1.id}/items"
  end

  it "Lists the names of all this merchants items" do
    expect(page).to have_content(Item.first.name)
    expect(page).to have_content(Item.second.name)
    expect(page).to have_content(Item.third.name)
    
    expect(page).to_not have_content(Item.fifth.name)
  end

  it "Does not have items from other merchants" do
    merchant_2 = create(:merchant)
    items = create(:item, name: "Please Not This", merchant_id: merchant_2.id)

    expect(page).to_not have_content(Item.fifth.name)
  end
end
