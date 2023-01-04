require 'rails_helper'

RSpec.describe 'merchant items index page' do
  it 'lists all items for a merchant' do
    mariah = Merchant.create!(name: "Mariah Ahmed")
    terry = Merchant.create!(name: "Terry Peeples")
    
    pen = mariah.items.create!(name: "pen", description: "writes stuff", unit_price: 33)
    marker = mariah.items.create!(name: "marker", description: "writes stuff", unit_price: 23)
    pencil = mariah.items.create!(name: "pencil", description: "writes stuff", unit_price: 13)

    socks = terry.items.create!(name: "socks", description: "keeps feet warm", unit_price: 8)
    shoes = terry.items.create!(name: "shoes", description: "provides arch support", unit_price: 68)

    visit merchant_item_index_path(mariah)

    expect(page).to have_content(pen.name)
    expect(page).to have_content(marker.name)
    expect(page).to have_content(pencil.name)
    expect(page).to have_no_content(socks.name)
  end
end
