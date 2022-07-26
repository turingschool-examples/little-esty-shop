require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @walmart = Merchant.create!(name: "Wal-Mart")

    @target = Merchant.create!(name: "Target")

    @costco = Merchant.create!(name: "Costco")

    @pencil = Item.create!( name: "Pencil",
                            description: "Sharpen it and write with it.",
                            unit_price: 199,
                            merchant_id: @walmart.id)

    @marker = Item.create!( name: "Marker",
                            description: "Washable!",
                            unit_price: 159,
                            merchant_id: @walmart.id)

    @eraser = Item.create!( name: "Eraser",
                            description: "Use it to fix mistakes.",
                            unit_price: 205,
                            merchant_id: @walmart.id)

    @highlighter = Item.create!( name: "Highlighter",
                            description: "Highlight things and make them yellow!",
                            unit_price: 305,
                            merchant_id: @walmart.id)

  end

  it 'has a list of all of the items for a merchant' do
    visit "/merchants/#{@walmart.id}/items"

    save_and_open_page

    expect(page).to have_content(@pencil.name)
    expect(page).to have_content(@marker.name)
    expect(page).to have_content(@eraser.name)
    expect(page).to_not have_content(@highlighter.name)
  end
end