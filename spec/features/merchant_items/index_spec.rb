require 'rails_helper'
RSpec.describe "Merchant item index" do
  before do
    @merchant1 = Merchant.create!(name: "Kelly")
    @merchant2 = Merchant.create!(name: "Craig")
    @item1 = @merchant1.items.create!(name: "Mixing Bowl", description: "xyz", unit_price: 500)
    @item2 = @merchant1.items.create!(name: "Gumball", description: "abc", unit_price: 25)
    @item3 = @merchant2.items.create!(name: "Hat", description: "sdasasdsd", unit_price: 88)
  end

  it 'I see a list of the names of all of my items' do
    # visit "merchants/#{@merchant1.id}/items"
    visit merchant_items_path(@merchant1)
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
  end
end
