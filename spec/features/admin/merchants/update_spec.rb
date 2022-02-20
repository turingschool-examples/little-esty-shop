require 'rails_helper'

RSpec.describe 'Admin Merchants Edit' do
  describe 'user story #15 - continued' do
    it "submits the edit form and udpates merchant" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants/#{merchant_1.id}"

      fill_in 'Name', with: "LT's T-shirts and Hoodies LLC"
      click_button 'Update Merchant'

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content("LT's T-shirts and Hoodies LLC")
      expect(page).to have_content("Successfully Updated Merchant Information")
    end

    it 'all info not updated - yeilds an error' do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")
      visit edit_admin_merchant_path(merchant_1.id)
      click_button 'Update Merchant'

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content("Error:")
      expect(page).to have_content("LT's T-shirts and Hoodies LLC")
    end
  end
end
