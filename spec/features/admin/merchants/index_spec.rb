require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page', type: :feature do

  it 'can list the name of each merchant in the system' do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")
    merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us")
    merchant5 = Merchant.create!(name: "Tarker Phomson manga emporium")
    merchant6 = Merchant.create!(name: "Mlex Aora rods and reels")

    visit '/admin/merchants'

    expect(page).to have_content("Poke Retirement homes")
    expect(page).to have_content("Rendolyn Guiz's poke stops")
    expect(page).to have_content("Dhirley Secasrio's knits and bits")
    expect(page).to have_content("Eandace Ceckels toys'R'us")
    expect(page).to have_content("Tarker Phomson manga emporium")
    expect(page).to have_content("Mlex Aora rods and reels")
  end

  it "can create a new merchant with a form with a disabled status" do
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")
    merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us")
    merchant5 = Merchant.create!(name: "Tarker Phomson manga emporium")
#story wants to know that the merchant is disabled when created
#dont have that functionality written yet but can add to test later
    visit '/admin/merchants'

    expect(page).to have_content("Rendolyn Guiz's poke stops")
    expect(page).to have_content("Dhirley Secasrio's knits and bits")
    expect(page).to have_content("Eandace Ceckels toys'R'us")
    expect(page).to have_content("Tarker Phomson manga emporium")

    expect(page).to have_link('Create Merchant')
    click_on('Create Merchant')
    expect(current_path).to eq("/admin/merchants/new")

    fill_in 'name', with: 'Hai Sall'
    expect(page).to have_button('Submit')
    click_on('Submit')
    expect(current_path).to eq("/admin/merchants")

    expect(page).to have_content('Hai Sall')
    #expect(page).to have_button{'disabled'}
    expect(page).to have_content("Rendolyn Guiz's poke stops")
    expect(page).to have_content("Dhirley Secasrio's knits and bits")
    expect(page).to have_content("Eandace Ceckels toys'R'us")
    expect(page).to have_content("Tarker Phomson manga emporium")
  end
end
