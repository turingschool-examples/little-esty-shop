require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Parker")
    @merchant_2 = Merchant.create!(name: "Kerri")
    @item1 = @merchant_1.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant_1.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    @item3 = @merchant_2.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 600)
    visit "/merchants/#{@merchant_1.id}/items/#{@item1.id}"
  end

  it 'shows the item name, description, current selling price' do

    expect(page).to have_content("-#{@item1.name}")
    expect(page).to have_content("-#{@item1.description}")
    expect(page).to have_content("-$#{@item1.unit_price}.00")
    expect(page).to_not have_content("-#{@item2.name}")
    expect(page).to_not have_content("-#{@item2.description}")
    expect(page).to_not have_content("-#{@item2.unit_price}")
    expect(page).to_not have_content("-#{@item3.name}")
    expect(page).to_not have_content("-#{@item3.description}")
    expect(page).to_not have_content("-#{@item3.unit_price}")
  end

  it 'shows a link to update item information' do 

    click_link "Update Item #{@item1.name}"
    
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}/edit")
  end
end
