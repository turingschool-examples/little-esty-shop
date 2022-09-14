require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
  describe 'As a merchant' do
    describe 'When I visit the merchant dashboard /merchants/merchant_id/dashboard' do
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:jewlery_ciry) { Merchant.create!(name: "Jewlery City Merchant")}
    
      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200) }
      let!(:peanut) { carly_silo.items.create!(name: "Peanut Bronzinos", description: "Peanut Caramel Chews", unit_price: 1500) }
      let!(:choco_waffle) { carly_silo.items.create!(name: "Chocolate Waffles Florentine", description: "Cholately Waffles of Deliciousness", unit_price: 900) }
      let!(:hummus) { carly_silo.items.create!(name: "Hummus", description: "Creamy Hummus", unit_price: 1200) }
    
      let!(:gold_earrings) { jewlery_ciry.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_ciry.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
      let!(:studded_bracelet) { jewlery_ciry.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) }
      let!(:dainty_anklet) { jewlery_ciry.items.create!(name: "Dainty Ankley", description: "An everyday ankley", unit_price: 2299) }
      let!(:stackable_rings) { jewlery_ciry.items.create!(name: "Stackable Gold Rings", description: "Small rings to be mixed and matched", unit_price: 1299) }

      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
      let!(:whitney) { Customer.create!(first_name: "Whitney", last_name: "Gains")}
      let!(:sydney) { Customer.create!(first_name: "Sydney", last_name: "Lang")}
      let!(:eddie) { Customer.create!(first_name: "Eddie", last_name: "Young")}
      let!(:ryan) { Customer.create!(first_name: "Ryan", last_name: "Vergeront")}
      let!(:leah) { Customer.create!(first_name: "Leah", last_name: "Anderson")}
      let!(:polina) { Customer.create!(first_name: "Polina", last_name: "Eisenberg")}

      let!(:whitney_invoice1) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice2) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice3) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice4) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice5) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice6) { whitney.invoices.create!(status: "completed")}
      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}
      let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
      let!(:alaina_invoice4) { alaina.invoices.create!(status: "completed")}
      let!(:alaina_invoice5) { alaina.invoices.create!(status: "completed")}
      let!(:alaina_invoice6) { alaina.invoices.create!(status: "completed")}
      let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed")}
      let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed")}
      let!(:eddie_invoice3) { eddie.invoices.create!(status: "completed")}
      let!(:ryan_invoice1) { ryan.invoices.create!(status: "completed")}
      let!(:ryan_invoice2) { ryan.invoices.create!(status: "completed")}
      let!(:polina_invoice1) { polina.invoices.create!(status: "completed")}
      let!(:polina_invoice1) { polina.invoices.create!(status: "cancelled")}
      let!(:leah_invoice1) { leah.invoices.create!(status: "cancelled")}
      let!(:leah_invoice2) { leah.invoices.create!(status: "in_progress")}







      it 'Then I see the name of my merchant' do

        visit "/merchants/#{carly_silo.id}/dashboard"

        expect(page).to have_content("Carly Simon's Candy Silo")
        expect(page).to_not have_content("Bavarian Motor Velocycles")
      end

      it 'Then I see link to my merchant items index (/merchants/merchant_id/items)' do

        visit "/merchants/#{carly_silo.id}/dashboard"

        expect(page).to have_content("#{carly_silo.name}'s Items")
        click_on("#{carly_silo.name}'s Items")
        expect(current_path).to eq(merchant_items_path("#{carly_silo.id}"))
      end

      it 'And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)' do

        visit "/merchants/#{carly_silo.id}/dashboard"

        expect(page).to have_content("#{carly_silo.name}'s Invoices")
        click_on("#{carly_silo.name}'s Invoices")
        expect(current_path).to eq(merchant_invoices_path("#{carly_silo.id}"))
      end

      it 'Then I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant' do

        # visit "/merchants/#{carly_silo.id}/dashboard"
        # expect(page).to have_content("Top 5 Customers")



      end

      it 'And next to each customer name I see the number of successful transactions they have
      conducted with my merchant' do

      end

    end
  end
end

