require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merch = Merchant.create!({name: "Douglas Olson"})
  end

  it "displays the name of the merchant" do
    visit "/merchants/#{@merch.id}/dashboard"

    expect(page).to have_content(@merch.name)
  end

  it "displays links to merchant items and invoices indexes" do
    visit "/merchants/#{@merch.id}/dashboard"

    expect(page).to have_link("My Items")
    click_link "My Items"
    expect(current_path).to eq("/merchants/#{@merch.id}/items")

    visit "/merchants/#{@merch.id}/dashboard"

    expect(page).to have_link("My Invoices")
    click_link "My Invoices"
    expect(current_path).to eq("/merchants/#{@merch.id}/invoices")
  end
end
