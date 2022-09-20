require "rails_helper"


RSpec.describe("Creates new item") do
  it("renders the new item form") do
    merchant1 = Merchant.create!(    name: "Bob")
    visit("/merchants/#{merchant1.id}/items/new")
    expect(page).to(have_content("Create new item"))
    expect(find("form")).to(have_content("Name"))
    expect(find("form")).to(have_content("Description"))
    expect(find("form")).to(have_content("Price"))
  end
end

describe("the item create") do
  context("given valid data") do
    it("creates the items and redirects to the merchant items index page") do
      merchant1 = Merchant.create!(      name: "Bob")
      visit("/merchants/#{merchant1.id}/items/new")
      fill_in("Name",       with: "5gum")
      fill_in("Description",       with: "BubbleGum")
      fill_in(:unit_price,       with: 1)
      click_button("Submit")
      expect(page).to(have_current_path("/merchants/#{merchant1.id}/items"))
      expect(page).to(have_content("5gum"))
    end
  end
end
