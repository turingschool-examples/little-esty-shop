require 'rails_helper'
RSpec.describe 'Merchant Bulk Discount Edit Page' do

  describe 'Lets us edit discount attributes' do
    #       Merchant Bulk Discount Edit
    #
    # As a merchant
    # When I visit my bulk discount show page
    # Then I see a link to edit the bulk discount
    # When I click this link
    # Then I am taken to a new page with a form to edit the discount
    # And I see that the discounts current attributes are pre-poluated in the form
    # When I change any/all of the information and click submit
    # Then I am redirected to the bulk discount's show page
    # And I see that the discount's attributes have been updated
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


      # expect(page).to have_content("#{discount_a.name}")
      # expect(page).to have_content("#{discount_a.percentage}")
      # expect(page).to have_content("#{discount_a.threshold}")
      # #sad path
      # expect(page).to_not have_content("#{discount_b.name}")
      # expect(page).to_not have_content("#{discount_b.percentage}")
      # expect(page).to_not have_content("#{discount_b.threshold}")
      # expect(page).to_not have_content("#{discount_a2.name}")
      # expect(page).to_not have_content("#{discount_a2.percentage}")
      # expect(page).to_not have_content("#{discount_a2.threshold}")
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


      # expect(page).to have_content("#{discount_a.name}")
      # expect(page).to have_content("#{discount_a.percentage}")
      # expect(page).to have_content("#{discount_a.threshold}")
      # #sad path
      # expect(page).to_not have_content("#{discount_b.name}")
      # expect(page).to_not have_content("#{discount_b.percentage}")
      # expect(page).to_not have_content("#{discount_b.threshold}")
      # expect(page).to_not have_content("#{discount_a2.name}")
      # expect(page).to_not have_content("#{discount_a2.percentage}")
      # expect(page).to_not have_content("#{discount_a2.threshold}")
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


      # expect(page).to have_content("#{discount_a.name}")
      # expect(page).to have_content("#{discount_a.percentage}")
      # expect(page).to have_content("#{discount_a.threshold}")
      # #sad path
      # expect(page).to_not have_content("#{discount_b.name}")
      # expect(page).to_not have_content("#{discount_b.percentage}")
      # expect(page).to_not have_content("#{discount_b.threshold}")
      # expect(page).to_not have_content("#{discount_a2.name}")
      # expect(page).to_not have_content("#{discount_a2.percentage}")
      # expect(page).to_not have_content("#{discount_a2.threshold}")
    end
  end
end
