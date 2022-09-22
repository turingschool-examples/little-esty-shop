require 'rails_helper'

RSpec.describe 'bulk discount index page', type: :feature do
  describe 'As a visitor' do
    describe 'When I visit the bulk discount index page' do
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

      let!(:carlys_discount1) {carly_silo.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
      let!(:carlys_discount2) {carly_silo.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
      let!(:carlys_discount3) {carly_silo.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 5)}

      it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do

        visit "/merchants/#{carly_silo.id}/bulk_discounts"

        within("#discount_#{carlys_discount1.id}") do 
          expect(page).to have_content("Discount ##{carlys_discount1.id}")
          expect(page).to have_content("Percentage Off: %#{carlys_discount1.percentage_discount}")
          expect(page).to have_content("Quantity of Items: #{carlys_discount1.quantity_threshold}")
          expect(page).to_not have_content("Quantity of Items: #{carlys_discount2.quantity_threshold}")

        end
      end

      it 'And each bulk discount listed includes a link to its show page' do

        visit "/merchants/#{carly_silo.id}/bulk_discounts"
        
        within("#discount_#{carlys_discount1.id}") do 
        expect(page).to have_link('View this Discount')
        click_link('View this Discount')
        end

        expect(current_path).to eq(merchant_bulk_discount_path(carly_silo, carlys_discount1.id))
      end

      it 'Then I see a link to create a new discount' do

        visit "/merchants/#{carly_silo.id}/bulk_discounts"
        expect(page).to have_link("Create a New Discount")
        click_link("Create a New Discount")
        expect(current_path).to be("/merchants/#{carly_silo.id}/bulk_discounts/new")
        expect(page).to have_content("Percentage Discount:")
        expect(page).to have_content("Quantity of Items:")
      end

      xit 'Then I see a link to create a new discount' do

        visit "/merchants/#{carly_silo.id}/bulk_discounts"

        fill_in("Percentage Discount:")
        click_on("Create Discount")
        expect(current_path).to eq("/merchants/#{carly_silo.id}/bulk_discounts")

        within("#discount_#{discount_that_was_just_Created.id}") do 
          expect(page).to have_content("what I filled this in with")
        end     

      end



    end
  end
end
