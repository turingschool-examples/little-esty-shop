require 'rails_helper'


RSpec.describe 'Merchant Bulk Discount Index Page' do

  describe 'As a Visitor' do
#     Merchant Bulk Discounts Index
#
# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
    it "has a link to the merchant's discounts" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      visit "/merchants/#{merchant_1.id}/dashboard"

      click_on "My Discounts"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
    end

    it "shows all the merchant's bulk discounts including their % discount and quantity thresholds" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Greg's Leggings")

      
    end


  end
end
