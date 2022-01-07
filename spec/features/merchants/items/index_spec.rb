require 'rails_helper'

RSpec.describe 'merchant item index page' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Parker")
    @merchant_2 = Merchant.create!(name: "Kerri")
    @item1 = @merchant_1.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant_1.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    @item3 = @merchant_2.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 600)
    visit "/merchants/#{@merchant_1.id}/items"
  end

  it 'shows each item name' do
    expect(page).to have_content("Small Thing")
    expect(page).to have_content("Large Thing")
  end

  it 'does not show items for any other merchant' do
    expect(page).to_not have_content("Medium Thing")
  end

  it 'the item name is a link to the merchant items show page' do
    click_link("#{@item1.name}")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}")
  end
end
