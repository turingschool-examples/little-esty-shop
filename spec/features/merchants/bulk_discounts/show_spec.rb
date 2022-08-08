require 'rails_helper'
RSpec.describe 'Merchant Bulk Discount Show Page' do

  describe 'Viewing all of a merchants discounts' do
    it "has a link to the merchant's discounts" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_c = merchant_1.bulkdiscounts.create!(name: "Discount C", percentage: 20, threshold: 20)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_a.id}"

      expect(page).to have_content("#{discount_a.name}")
      expect(page).to have_content("#{discount_a.percentage}")
      expect(page).to have_content("#{discount_a.threshold}")
      save_and_open_page
    end
  end
end
