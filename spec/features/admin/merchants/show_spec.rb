require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'user story #16' do
    it "when clicking merchant name I am directed to that merchants show page" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants"
      click_link("#{merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    end

    it "Merchants name appears on show page" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants/#{merchant_1.id}"

      expect(page).to have_content("#{merchant_1.name}")
    end
  end

  describe 'user story #15' do
    it "Link to Update Merchant appears on show page" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants/#{merchant_1.id}"
      expect(page).to have_link("Update Merchant")
    end

    it "Update Merchant links to merchant edit page - shows form with existing attribute info" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants/#{merchant_1.id}"
      click_link("Update Merchant")

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")
    end

    it "updates are submitted - redirected back to admin/merchant show page w/ updated info and flash message" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      visit "/admin/merchants/#{merchant_1.id}/edit"
      fill_in 'Name', with: "LT's T-shirts and Hoodies LLC"
      click_button("Update Merchant")

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content("LT's T-shirts and Hoodies LLC")
      expect(page).to have_content("Successfully Updated Merchant Information")
    end
  end
end
