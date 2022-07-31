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
end




