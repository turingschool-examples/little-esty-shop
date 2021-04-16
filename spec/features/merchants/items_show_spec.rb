require 'rails_helper'

RSpec.describe "Merchant item index page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Ice Cream Parlour')
    @merchant_2 = Merchant.create!(name: 'Ice Cream Parlour')
    @item_1 = @merchant_1.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: 'Back scratch', description: 'skirtch back', unit_price: 5)
    @item_3 = @merchant_2.items.create!(name: 'Pooper Scooper', description: 'holds doge poo', unit_price: 13)
    visit "/merchant/#{@merchant_1.id}/items/#{@item_1.id}"
  end

  it 'displays the items attributes' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end

  it 'shows a link to update the item info' do
    expect(page).to have_link("Update Item")
  end

  it 'can edit a form for the item and update the item' do
    click_link "Update Item"

    expect(current_path).to eq("/merchant/#{@merchant_1.id}/items/#{@item_1.id}/edit")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Unit price")

    fill_in "Name", with: "Cookies"
    fill_in "Description", with: "Enjoy some chocolate chip cookies"
    fill_in "Unit price", with: 5
    click_button "Submit"

    expect(current_path).to eq("/merchant/#{@merchant_1.id}/items/#{@item_1.id}")
    expect(page).to have_content("Cookies")
    expect(page).to have_content("Enjoy some chocolate chip cookies")
    expect(page).to have_content(5)
    expect(page).to have_content("Item successfully updated")
  end

  # it 'can not edit a form completley and get a flash' do
  #   click_link "Update Item"
  #
  #   expect(current_path).to eq("/merchant/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  #   expect(page).to have_content("Name")
  #   expect(page).to have_content("Description")
  #   expect(page).to have_content("Unit price")
  #
  #   fill_in "Name", with: "Cookies"
  #   fill_in "Description", with: false
  #   fill_in "Unit price", with: false
  #   click_button "Submit"
  #
  #   expect(page).to have_content("Please fill in all fields.")
  #   expect(current_path).to eq("/merchant/#{@merchant_1.id}/items/#{@item_1.id}/edit")
  #   expect(page).to have_content("Name")
  #   expect(page).to have_content("Description")
  #   expect(page).to have_content("Unit price")
  # end
end
