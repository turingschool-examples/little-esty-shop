require 'rails_helper'


RSpec.describe 'Merchant Bulk Discount New Page' do

  describe 'Creating a new discount' do
    it "has a link that redirects me to a form to add a new bulk discount" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts"

      click_on "Create New Bulk Discount"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts/new")
    end

    it "fill out the form and am redirected to the index where the new discount is shown" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts"

      click_on "Create New Bulk Discount"

      fill_in "Name", with: "Discount C1"
      fill_in "Percentage", with: 20
      fill_in "Threshold", with: 20
      click_on "Submit"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts")
      expect(page).to have_content("Discount C1")
    end

  end

end
