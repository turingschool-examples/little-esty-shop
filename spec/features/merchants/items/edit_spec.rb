require 'rails_helper'

RSpec.describe 'MerchantItems edit page' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Parker")
    @merchant_2 = Merchant.create!(name: "Kerri")
    @item1 = @merchant_1.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)
    @item2 = @merchant_1.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)
    @item3 = @merchant_2.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 600)
    visit "/merchants/#{@merchant_1.id}/items/#{@item1.id}/edit"
  end

  it 'has a preloaded form to edit merchant item information' do
    visit "/merchants/#{@merchant_1.id}/items/#{@item1.id}"

    click_link "Update Item #{@item1.name}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}/edit")

    expect(page).to have_field(:name, with: @item1.name)
    expect(page).to have_field(:description, with: @item1.description)
    expect(page).to have_field(:unit_price, with: @item1.unit_price)

    fill_in :name, with: "Smallie"
    fill_in :description, with: "Smallmouth Bass"
    fill_in :unit_price, with: 400
    click_button "Update Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item1.id}")

    expect(page).to have_content("-Smallie")
    expect(page).to have_content("-Smallmouth Bass")
    expect(page).to have_content("-$400.00")
    expect(page).to have_content("Successfully Updated Item")
  end
end
