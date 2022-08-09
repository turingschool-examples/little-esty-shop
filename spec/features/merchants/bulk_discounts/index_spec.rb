require 'rails_helper'


RSpec.describe 'Merchant Bulk Discount Index Page' do

  describe 'Viewing all of a merchants discounts' do
    it "has a link to the merchant's discounts" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      visit "/merchants/#{merchant_1.id}/dashboard"

      click_on "My Discounts"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts")
    end

    it "shows all the merchant's bulk discounts including their % discount and quantity thresholds" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
      discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
      discount_a2 = merchant_2.bulkdiscounts.create!(name: "Discount A2", percentage: 25, threshold: 25)

      visit "/merchants/#{merchant_1.id}/bulkdiscounts"

      expect(page).to_not have_content("#{discount_a2.name}")
      expect(page).to_not have_content("#{discount_a2.percentage}")
      expect(page).to_not have_content("#{discount_a2.threshold}")

      within "#bulk_discount0" do
        expect(page).to have_content("#{discount_a.name}")
        expect(page).to have_content("#{discount_a.percentage}")
        expect(page).to have_content("#{discount_a.threshold}")
        expect(page).to_not have_content("#{discount_a2.name}")
        expect(page).to_not have_content("#{discount_a2.percentage}")
        expect(page).to_not have_content("#{discount_a2.threshold}")
      end
      within "#bulk_discount1" do
        expect(page).to have_content("#{discount_b.name}")
        expect(page).to have_content("#{discount_b.percentage}")
        expect(page).to have_content("#{discount_b.threshold}")

        click_on "#{discount_b.name} Show Page"

        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts/#{discount_b.id}")
      end
    end
#   Merchant Bulk Discount Delete
#
  # As a merchant
  # When I visit my bulk discounts index
  # Then next to each bulk discount I see a link to delete it
  # When I click this link
  # Then I am redirected back to the bulk discounts index page
  # And I no longer see the discount listed
  it "has a working delete link" do
    merchant_1 = Merchant.create!(name: "Bobs Loggers")

    discount_a = merchant_1.bulkdiscounts.create!(name: "Discount A", percentage: 10, threshold: 10)
    discount_b = merchant_1.bulkdiscounts.create!(name: "Discount B", percentage: 15, threshold: 15)
    discount_c = merchant_1.bulkdiscounts.create!(name: "Discount C", percentage: 20, threshold: 20)

    visit "/merchants/#{merchant_1.id}/bulkdiscounts"

    within "#bulk_discount0" do
      expect(page).to have_content("#{discount_a.name}")
      expect(page).to have_content("#{discount_a.percentage}")
      expect(page).to have_content("#{discount_a.threshold}")

      click_on "Delete Discount"
      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulkdiscounts")
    end

    within "#bulk_discount0" do
      expect(page).to_not have_content("#{discount_a.name}")
      expect(page).to_not have_content("#{discount_a.percentage}")
      expect(page).to_not have_content("#{discount_a.threshold}")
      expect(page).to have_content("#{discount_b.name}")
      expect(page).to have_content("#{discount_b.percentage}")
      expect(page).to have_content("#{discount_b.threshold}")
    end
  end

  end
end
