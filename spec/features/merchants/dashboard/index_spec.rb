require 'rails_helper'

RSpec.describe 'merchant show dashboard index page', type: :feature do
  describe "as a merchant visiting '/merchants/merchant_id/dashboard'" do
    let!(:merchant1) {Merchant.create!(uuid: 101, name: "Brian's Beads")}
    
    it 'shows my name(merchant)' do
      
      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_content("Brian's Beads")
    end

    it "will have a link that takes me to the 'merchants/merchant_id/items index page" do 

      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_link("Merchant Items")

      click_link("Merchant Items")

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    end

    it "will have a link that takes me to the 'merchants/merchant_id/invoices index page" do 

      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_link("Merchant Invoices")

      click_link("Merchant Invoices")

      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
    end 
  end
end