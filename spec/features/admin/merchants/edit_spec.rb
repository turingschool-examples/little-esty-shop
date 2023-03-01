require 'rails_helper'

RSpec.describe "admin merchants edit", :vcr do

  describe 'merchant edit' do
    it 'links to a merchant edit page' do
      @merchant_1 = Merchant.create!(name: "Mel's Travels")
      visit "/admin/merchants/#{@merchant_1.id}"
  
      click_on("Update #{@merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

      fill_in "Name", with: "Merchanty Merchant"
      
      click_on("Update")
      
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(page).to have_content("Merchanty Merchant")
    end
  end
end