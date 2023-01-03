require 'rails_helper'

RSpec.describe "merchant dashboard" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")
  end

  it 'will show the name of the merchant' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard")
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'will have a link to the merchant item index' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("My Items")

    click_link "My Items"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it 'will have a link to my merchant invoices index' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("My Invoices")

    click_link "My Invoices"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end
end