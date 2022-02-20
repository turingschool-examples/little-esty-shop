require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'user story #16' do
    it "when clicking merchant name I am directed to that merchants show page" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants"
      click_link("#{merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}"))
    end

    it "Merchants name appears on show page" do
      merchant_1 = Merchant.create!(name: "LT's Tee Shirts LLC")

      visit "/admin/merchants/#{merchant_1.id}"

      expect(page).to have_content("#{merchant_1.name}"))
    end
  end
end
