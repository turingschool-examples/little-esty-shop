require 'rails_helper'

RSpec.describe "merchant's bulk discounts index" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:bulk_discount1) { merchant1.discounts.create!(discount: 0.20, quantity_threshold: 10) }
  let!(:bulk_discount2) { merchant1.discounts.create!(discount: 0.50, quantity_threshold: 20) }

  # before do
  #
  # end

  it "a merchant's bulk discounts index page lists all discounts, percentage discount, and quantity thresholds" do
    # expect()
  end

  it "each bulk discount listed includes a link directs you its show page" do

  end
end

# Merchant Bulk Discounts Index
#
# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
