require "rails_helper"


RSpec.describe("Merchant Items Show Page") do
  it("i see all the items attributes including Name/Description/Current Selling price") do
    merchant1 = Merchant.create!(    name: "Bob")
    merchant2 = Merchant.create!(    name: "Jolene")
    item1 = merchant1.items.create!(    name: "item1",     description: "this is item1 description",     unit_price: 1)
    item2 = merchant1.items.create!(    name: "item2",     description: "this is item2 description",     unit_price: 2)
    item3 = merchant1.items.create!(    name: "item3",     description: "this is item3 description",     unit_price: 3)
    item4 = merchant2.items.create!(    name: "item3",     description: "this is item4 description",     unit_price: 3)
    visit("/merchants/#{merchant1.id}/items/#{item1.id}")
    expect(page).to(have_content(item1.name))
    expect(page).to(have_content(item1.description))
    expect(page).to(have_content(item1.unit_price))
  end
end
