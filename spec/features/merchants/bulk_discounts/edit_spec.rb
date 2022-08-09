require 'rails_helper'
RSpec.describe 'Merchant Bulk Discount Edit Page' do

  describe 'Lets us edit discount attributes' do
    it "has a link to let a merchant edit the discount attributes" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_c = merchant_1.bulkdiscounts.create!(name: "Discount C", percentage: 20, threshold: 20)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}"

      click_on "Edit Discount"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}/edit")
    end

    it "has a link to let a merchant edit the discount attributes" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_c = merchant_1.bulkdiscounts.create!(name: "Discount C", percentage: 20, threshold: 20)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}"

      click_on "Edit Discount"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}/edit")
    end

    it "lets a merchant edit the attributes of a discount" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2= Merchant.create!(name: "Bobs Loggers")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 11)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_c = merchant_1.bulkdiscounts.create!(name: "Discount C", percentage: 20, threshold: 20)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}"

      expect(page).to have_content("#{discount_a.name}")
      expect(page).to have_content("#{discount_a.percentage}")
      expect(page).to have_content("#{discount_a.threshold}")

      click_on "Edit Discount"

      fill_in "Name", with: "Discount A1"
      fill_in "Percentage", with: 5
      fill_in "Threshold", with: 6

      click_on "Update"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}")
      expect(page).to have_content("Discount A1")
      expect(page).to have_content(5)
      expect(page).to have_content(6)

      expect(page).to_not have_content(10)
      expect(page).to_not have_content(11)
    end
  end
end
