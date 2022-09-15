require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe 'US6' do
    it 'shows the name of all the merchants in the system' do
      merchant_1 = Merchant.create!(name: "Bread Pitt")
      merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
      merchant_3 = Merchant.create!(name: "Sheena Yeaston")
      merchant_4 = Merchant.create!(name: "Taylor Sift")

      visit "/admin/merchants"

      expect(page).to have_content("Bread Pitt")
      expect(page).to have_content("Carrie Breadshaw")
      expect(page).to have_content("Sheena Yeaston")
      expect(page).to have_content("Taylor Sift")
      expect(page).to_not have_content("Meat Loaf") #customer name
    end
  end

  describe 'US7' do
    it 'has a link on each merchants name taking you to their individual show page with their name' do
      merchant_1 = Merchant.create!(name: "Bread Pitt")
      merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

      visit "/admin/merchants"
      click_link "#{merchant_1.name}"

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content("Bread Pitt")
      expect(page).to_not have_content("Carrie Breadshaw")
    end
  end

end