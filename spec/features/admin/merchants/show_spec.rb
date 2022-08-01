require 'rails_helper'

RSpec.describe 'Admin Show page', type: :feature do

  it "can update the merchant's information" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    visit "/admin/merchants/#{merchant1.id}"

      expect(page).to have_link('Update Merchant')
      click_on('Update Merchant')
      expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")

      fill_in 'Name', with: 'Another Merchant'
      expect(page).to have_button('Submit')
      click_button('Submit')
      expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
      expect(page).to have_content('Another Merchant')
      expect(page).to have_content('The information has been successfully updated')
      expect(page).to_not have_content('Poke Retirement homes')
  end

  it "Can link the merchant index page to the merchants admin show page by clicking the name of the merchant" do
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: "enabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

    visit "/admin/merchants"

    expect(page).to have_link("#{merchant1.name}")
    click_on("#{merchant1.name}")

    expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
    expect(page).to have_content("Poke Retirement homes")
    expect(page).to_not have_content("Rendolyn Guiz's poke stops")
    expect(page).to_not have_content("Dhirley Secasrio's knits and bits")

    visit "/admin/merchants"

    expect(page).to have_link("#{merchant2.name}")
    click_on("#{merchant2.name}")
  
    expect(current_path).to eq("/admin/merchants/#{merchant2.id}")
    expect(page).to have_content("Rendolyn Guiz's poke stops")
    expect(page).to_not have_content("Poke Retirement homes")
    expect(page).to_not have_content("Dhirley Secasrio's knits and bits")

    visit "/admin/merchants"

    expect(page).to have_link("#{merchant2.name}")
    click_on("#{merchant3.name}")
   
    expect(current_path).to eq("/admin/merchants/#{merchant3.id}")
    expect(page).to have_content("Dhirley Secasrio's knits and bits")
    expect(page).to_not have_content("Rendolyn Guiz's poke stops")
    expect(page).to_not have_content("Poke Retirement homes")
  end
end
