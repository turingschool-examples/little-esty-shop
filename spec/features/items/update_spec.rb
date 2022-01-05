require 'rails_helper'

RSpec.describe 'the merchant item update page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Kelly")
    @merchant2 = Merchant.create!(name: "Craig")
    @item1 = @merchant1.items.create!(name: "Mixing Bowl", description: "xyz", unit_price: 500)
    @item2 = @merchant1.items.create!(name: "Gumball", description: "abc", unit_price: 25)
    @item3 = @merchant2.items.create!(name: "Hat", description: "sdasasdsd", unit_price: 88)
  end

  it 'has a link to edit the item' do
    visit merchant_item_path(@merchant1, @item1)

    click_link "Edit #{@item1.name}"
    expect(current_path).to eq(edit_merchant_item_path(@merchant1.id, @item1.id))
  end

  it 'updates the items information and redirects to show page' do
    visit edit_merchant_item_path(@merchant1.id, @item1.id)

    fill_in(:name, with: "Salad Bowl")
    fill_in(:description, with: "it's for salad")
    fill_in(:unit_price, with: 1000)
    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    expect(page).to have_content("Salad Bowl")
    expect(page).to_not have_content("Mixing Bowl")
    expect(page).to have_content("it's for salad")
    expect(page).to_not have_content("xyz")
    expect(page).to have_content(1000)
    expect(page).to_not have_content(500)
  end

  it 'displays a successfully updated flash message' do
    visit edit_merchant_item_path(@merchant1.id, @item1.id)

    fill_in(:name, with: "Salad Bowl")
    fill_in(:description, with: "it's for salad")
    fill_in(:unit_price, with: 1000)
    click_button "Submit"

    expect(page).to have_content("Successfully Updated")
  end
end
