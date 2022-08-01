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

  it "each mechant has a button to disable or enable the merchant" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guiz's poke stops", status: "enabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "disabled")
    merchant4 = Merchant.create!(name: "Eandace Ceckels toys'R'us", status: "disabled")

    visit '/admin/merchants' 
   
    within "div#merchant-#{merchant1.id}" do
      expect(page).to have_content("Poke Retirement homes")
      expect(page).to have_content("Status: enabled")  
      expect(page).to have_button('Enable/Disable')
      click_button('Enable/Disable')
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("Status: disabled")  
    end

    visit "/admin/merchants"

    within "div#merchant-#{merchant2.id}" do
      expect(page).to have_content("Rendolyn Guiz's poke stops")
      expect(page).to have_content("Status: enabled")  
      expect(page).to have_button('Enable/Disable')
      click_button('Enable/Disable')
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("Status: disabled") 
    end

    visit "/admin/merchants"

    within "div#merchant-#{merchant3.id}" do
      expect(page).to have_content("Dhirley Secasrio's knits and bits")
      expect(page).to have_content("Status: disabled")  
      expect(page).to have_button('Enable/Disable')
      click_button('Enable/Disable')
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("Status: enabled") 
    end

     within "div#merchant-#{merchant4.id}" do
      expect(page).to have_content("Eandace Ceckels toys'R'us")
      expect(page).to have_content("Status: disabled")  
      expect(page).to have_button('Enable/Disable')
      click_button('Enable/Disable')
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("Status: enabled") 
    end
  end
end