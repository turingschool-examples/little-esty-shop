require 'rails_helper'

RSpec.describe "merchant items edit page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create(name: "Schroeder-Jerde" )
    @merchant_2 = Merchant.create(name: "Klein, Rempel and Jones")
    @item_1 = @merchant_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merchant_2.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)

  end
  it "shows edit form for item" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"

    expect(page).to have_field("Name", with: 'Two-Leg Pantaloons')
    expect(page).to have_field("Description", with: 'pants built for people with two legs')
    expect(page).to have_field("Price in Cents", with: '5000')
    expect(page).to have_button("Submit")
  end

  it "can update item" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit"

    fill_in "Name", with: "One-Leg Pantaloons"
    click_button "Submit"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    expect(controller).to set_flash[:success]
  end

end