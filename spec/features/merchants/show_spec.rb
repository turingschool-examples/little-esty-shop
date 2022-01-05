require 'rails_helper'

RSpec.describe "Merchant Dashboad Show Page" do
  it 'shows merchant name' do
    merch_1 = Merchant.create!(name: "Shop Here")

    visit "/merchants/#{merch_1.id}/dashboard"

    within ".merchant" do
      expect(page).to have_content("Merchant Name: #{merch_1.name}")
    end
  end

  it "links to items index" do
    merch_1 = Merchant.create!(name: "Shop Here")
    visit "/merchants/#{merch_1.id}/dashboard"

    expect(page).to have_content("Items Index")
    click_link "Items Index"
    expect(current_path).to eq("/merchants/#{merch_1.id}/items")
  end

  it "links to invoices index" do
    merch_1 = Merchant.create!(name: "Shop Here")
    visit "/merchants/#{merch_1.id}/dashboard"

    expect(page).to have_content("Invoices Index")
    click_link "Invoices Index"
    expect(current_path).to eq("/merchants/#{merch_1.id}/invoices")
  end
end
