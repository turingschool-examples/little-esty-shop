require 'rails_helper'
RSpec.describe "Merchant Index Page Delete", type: :feature do
  describe "User Story 4 - Bulk Discounts Delete" do
    it "can delete the discount" do
      merchant = create_list(:merchant, 2)
      bulk_discount1 = merchant[0].bulk_discounts.create!(threshold: 10, discount_percentage: 20)

      visit merchant_bulk_discounts_path(merchant[0])

      within "#leftSide2" do
        within "#bulk-discount-#{bulk_discount1.id}" do
          expect(page).to have_content("Threshold: #{bulk_discount1.threshold}")
          expect(page).to have_content("Discount Percentage: #{bulk_discount1.discount_percentage}")
          expect(page).to have_link("Delete Discount")
          click_link "Delete Discount"
  end
end
      expect(current_path).to eq merchant_bulk_discounts_path(merchant[0])
      expect(page).to_not have_content("ID: #{bulk_discount1.id}")
      expect(page).to_not have_content("Threshold: #{bulk_discount1.threshold}")
      expect(page).to_not have_content("Discount Percentage: #{bulk_discount1.discount_percentage}")
  end
end
end
