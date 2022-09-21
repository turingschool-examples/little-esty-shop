require "rails_helper"


RSpec.describe("Creates new item") do
  it("renders the new item form") do
    merchant1 = Merchant.create!(    name: "Bob")

    visit("/merchants/#{merchant1.id}/items/new")

    expect(page).to(have_content("Create new item"))

    expect(find("form")).to(have_content("Name"))
    expect(find("form")).to(have_content("Description"))
    expect(find("form")).to(have_content("Unit price"))
  end
end

describe("create a new item") do
  it("creates new item and the enabled status is false by default") do
    merchant1 = Merchant.create!(      name: "Bob")

    visit(new_merchant_item_path(merchant1))

    fill_in("Name",       with: "5gum")
    fill_in("Description",       with: "BubbleGum")
    fill_in("Unit price",       with: 1)
    click_button("Submit")

    expect(current_path).to(eq(merchant_items_path(merchant1)))
    expect(page).to(have_content("5gum"))

    newly_created_item = Item.find_by(name: '5gum')
    expect(newly_created_item.enabled).to(eq(false))
  end
end
