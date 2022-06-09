require 'rails_helper'

RSpec.describe "Bulk Discounts Index Page", type: :feature
  describe 'User Story 1 - Bulk Discounts Index' do
   it "visits the merchant dashboard and has a link that goes to the bulk discounts home page" do
     merchant = create_list(:merchant, 2)

     bulk_discount1 = merchant[0].bulk_discounts.create!(threshold: 10, discount_percentage: 20)
     bulk_discount2 = merchant[0].bulk_discounts.create!(threshold: 15, discount_percentage: 15)
     bulk_discount3 = merchant[1].bulk_discounts.create!(threshold: 15, discount_percentage: 30)

     item1 =  create(:item, merchant: merchant)
     item2 = create(:item, merchant: merchant)

     customer1 =  create(:customer)
     customer2 =  create(:customer)

     invoice1 =  create(:invoice, customer: customer1)
     invoice2 =  create(:invoice, customer: customer2)

     transaction1 =  create(:transaction, invoice: invoice1, result: 1)
     transaction2 =  create(:transaction, invoice: invoice2, result: 1)

     invoice_item1 =  create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011)
     invoice_item2 =  create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524)

     visit "/merchants/#{merchant[0].id}/dashboard"

     within '#rightSide' do
      expect(page).to have_link("View All My Discounts")
      click_link("View All My Discounts")
    end

    expect(current_path).to eq("/merchants/#{merchant[0].id}/bulk_discounts/index")

    within '#leftSide2' do
      within "#bulk-discount-#{@bulk_discount1.id}" do
        expect(page).to have_content("Threshold: #{bulk_discount1.threshold}")
        expect(page).to have_content("Discount Percentage:#{bulk_discount1.discount_percentage}")
        expect(page).to_not have_content("Threshold: #{bulk_discount3.threshold}")
        expect(page).to_not have_content("Discount Percentage: #{bulk_discount3.discount_percentage}")
        expect(page).to have_link("Id: #{bulk_discount1.id}")
      end

      within "#bulk-discount-#{@bulk_discount2.id}" do
        expect(page).to have_content("Threshold: #{bulk_discount2.threshold}")
        expect(page).to have_content("Discount Percentage: #{bulk_discount2.discount_percentage}")
        expect(page).to_not have_content("Threshold: #{bulk_discount3.threshold}")
        expect(page).to_not have_content("Discount Percentage: #{bulk_discount3.discount_percentage}")
        expect(page).to have_link("Id: #{bulk_discount2.id}")

        click_link("Id: #{bulk_discount2.id}")
      end

      expect(current_path).to eq("/merchants/#{merchant[0].id}/bulk_discounts/#{bulk_discount2.id}")
    end
  end
end
