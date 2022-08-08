require 'rails_helper'
RSpec.describe 'Merchant Bulk Discount Show Page' do

  describe 'Shows the percentage and threshold of a discount' do
    it "shows the the discount attributes" do
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
      #sad path
      expect(page).to_not have_content("#{discount_b.name}")
      expect(page).to_not have_content("#{discount_b.percentage}")
      expect(page).to_not have_content("#{discount_b.threshold}")
      expect(page).to_not have_content("#{discount_a2.name}")
      expect(page).to_not have_content("#{discount_a2.percentage}")
      expect(page).to_not have_content("#{discount_a2.threshold}")
    end
  end
end
