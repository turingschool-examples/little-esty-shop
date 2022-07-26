require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  it 'has the name of the merchant' do
    merchant = Merchant.create!(name: "Wizards Chest")
    merchant_2 = Merchant.create!(name: "REI")
    

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_content("Wizards Chest")
    expect(page).to_not have_content("REI")
    
  end

  it 'has links to merchant items index and merchant invoices index' do
    merchant = Merchant.create!(name: "Wizards Chest")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link("My Items")
    click_link("My Items")
    expect(current_path).to eq("/merchants/#{merchant.id}/items")

    visit "/merchants/#{merchant.id}/dashboard"

    expect(page).to have_link("My Invoices")
    click_link("My Invoices")
    expect(current_path).to eq("/merchants/#{merchant.id}/invoices")
  end
end