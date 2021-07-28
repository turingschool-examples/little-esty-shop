require 'rails_helper'

RSpec.describe 'Merchants Items Show page' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item = create(:item, merchant_id: @merchant_1.id)

    visit "/merchants/#{@merchant_1.id}/items/#{@item.id}"
  end

  it "lists all the items attriutes" do
    expect(page).to have_content(@item.name)
    expect(page).to have_content(@item.description)
    expect(page).to have_content(@item.unit_price)
  end

  it "has link to update the item information" do
    click_link "Update #{@item.name}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item.id}/edit")
  end

  it "can update infromation and return to show page" do
    click_link "Update #{@item.name}"

    fill_in :name, with: "Pixel 2 XL"
    fill_in :description, with: "When I left you, I was but the learner."
    fill_in :unit_price, with: 199

    click_button "Update Product"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item.id}")

    expect(page).to have_content("Pixel 2 XL")
    expect(page).to have_content("When I left you, I was but the learner.")
    expect(page).to have_content(199)
  end
end
