require 'rails_helper'
RSpec.describe "Merchant item show" do
  before do
    @merchant1 = Merchant.create!(name: "Kelly")
    @merchant2 = Merchant.create!(name: "Craig")
    @item1 = @merchant1.items.create!(name: "Mixing Bowl", description: "xyz", unit_price: 500)
    @item2 = @merchant1.items.create!(name: "Gumball", description: "abc", unit_price: 25)
    @item3 = @merchant2.items.create!(name: "Hat", description: "sdasasdsd", unit_price: 88)
  end

  it 'I see all of the items attributes' do
    visit merchant_items_path(@merchant1)
    click_link "#{@item1.name}"

    expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content(@item1.unit_price)
  end

  it 'has a link to an edit page for the item' do
    # "/merchants/#{item.merchant.id}/items/#{item.id}"
    visit merchant_item_path(@merchant1, @item1)
    click_link "Edit #{@item1.name}"

    expect(current_path).to eq(edit_merchant_item_path(@item1))
  end

  xit 'updates the items information and redirects to show page' do

  end

  xit 'displays a successfully updated flash message' do

  end
end
