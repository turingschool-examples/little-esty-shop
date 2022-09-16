require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
  describe 'As a merchant' do
    describe 'When I visit the merchant dashboard /merchants/merchant_id/dashboard' do
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
    
      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200) }
      let!(:peanut) { carly_silo.items.create!(name: "Peanut Bronzinos", description: "Peanut Caramel Chews", unit_price: 1500) }
      let!(:choco_waffle) { carly_silo.items.create!(name: "Chocolate Waffles Florentine", description: "Cholately Waffles of Deliciousness", unit_price: 900) }
      let!(:hummus) { carly_silo.items.create!(name: "Hummus", description: "Creamy Hummus", unit_price: 1200) }
    
      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
      let!(:studded_bracelet) { jewlery_city.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) }
      let!(:dainty_anklet) { jewlery_city.items.create!(name: "Dainty Ankley", description: "An everyday ankley", unit_price: 2299) }
      let!(:stackable_rings) { jewlery_city.items.create!(name: "Stackable Gold Rings", description: "Small rings to be mixed and matched", unit_price: 1299) }

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
      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed", created_at: "2012-01-30 14:54:09")}
      let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress", created_at: "2012-04-30 14:54:09")}
      let!(:alaina_invoice3) { alaina.invoices.create!(status: "completed", created_at: "2012-10-30 14:54:09")}
      let!(:alaina_invoice4) { alaina.invoices.create!(status: "completed", created_at: "2000-04-30 14:54:09")}
      let!(:alaina_invoice5) { alaina.invoices.create!(status: "completed", created_at: "2023-02-30 14:54:09")}
      let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed", created_at: "2022-04-30 14:54:09")}
      let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed", created_at: "1989-04-30 14:54:09")}
      let!(:eddie_invoice3) { eddie.invoices.create!(status: "completed", created_at: "1991-04-30 14:54:09")}
      let!(:ryan_invoice1) { ryan.invoices.create!(status: "completed", created_at: "1994-04-30 14:54:09")}
      let!(:ryan_invoice2) { ryan.invoices.create!(status: "completed", created_at: "1995-04-30 14:54:09")}
      let!(:polina_invoice1) { polina.invoices.create!(status: "completed", created_at: "1996-04-30 14:54:09")}
      let!(:polina_invoice2) { polina.invoices.create!(status: "cancelled", created_at: "1997-04-30 14:54:09")}
      let!(:leah_invoice1) { leah.invoices.create!(status: "cancelled")}
      let!(:leah_invoice2) { leah.invoices.create!(status: "in_progress")}

      let!(:whitney_invoice1_transaction) { whitney_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:whitney_invoice2_transaction) { whitney_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:whitney_invoice3_transaction) { whitney_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:whitney_invoice4_transaction) { whitney_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:whitney_invoice5_transaction) { whitney_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:whitney_invoice6_transaction) { whitney_invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:alaina_invoice1_transaction) { alaina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:alaina_invoice2_transaction) { alaina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:alaina_invoice3_transaction) { alaina_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:alaina_invoice4_transaction) { alaina_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:alaina_invoice5_transaction) { alaina_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:eddie_invoice1_transaction) { eddie_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:eddie_invoice2_transaction) { eddie_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:eddie_invoice3_transaction) { eddie_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:polina_invoice1_transaction) { polina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:polina_invoice2_transaction) { polina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:ryan_invoice1_transaction) { ryan_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
      let!(:ryan_invoice2_transaction) { ryan_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}
      let!(:leah_invoice1_transaction) { leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}
      let!(:leah_invoice2_transaction) { leah_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "failed")}

      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice2_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: gold_earrings.id, quantity: 40, unit_price: 1500, status:"packaged" )}
      let!(:alainainvoice3_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice3.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1600, status:"packaged" )}
      let!(:alainainvoice4_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice4.id, item_id: gold_earrings.id, quantity: 4, unit_price: 2400, status:"packaged" )}
      let!(:alainainvoice5_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice5.id, item_id: gold_earrings.id, quantity: 243, unit_price: 27000, status:"shipped" )}

      let!(:whitneyinvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice1.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice2_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice2.id, item_id: silver_necklace.id, quantity: 31, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice3_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice3.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice4_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice4.id, item_id: silver_necklace.id, quantity: 10, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice5_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice5.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice6_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice6.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}

      let!(:eddie_invoice1_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice1.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2199, status: "packaged" )}
      let!(:eddie_invoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice2.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2700, status: "packaged" )}
      let!(:eddie_invoice3_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice3.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 10299, status:"packaged")}

      let!(:polina_invoice1_itemdainty_anklet) { InvoiceItem.create!(invoice_id: polina_invoice1.id, item_id: dainty_anklet.id, quantity: 6, unit_price: 270, status:1)}
      let!(:polina_invoice2_itemdainty_anklet) { InvoiceItem.create!(invoice_id: polina_invoice2.id, item_id: dainty_anklet.id, quantity: 1, unit_price: 270, status:1 )}

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

        visit "/merchants/#{jewlery_city.id}/dashboard"

        expect(page).to have_content("Top 5 Customers")

        within('#top_5_customers') do 
        expect(whitney.first_name).to appear_before(alaina.first_name)
        expect(alaina.first_name).to appear_before(eddie.first_name)
        expect(eddie.first_name).to appear_before(polina.first_name)
        expect(polina.first_name).to appear_before(ryan.first_name)
        expect(page).to_not have_content(leah.first_name)
      end

      end

      it 'And next to each customer name I see the number of successful transactions they have
      conducted with my merchant' do

      visit "/merchants/#{jewlery_city.id}/dashboard"
      
        expect(page).to have_content("Top 5 Customers")
        
        within('#top_5_customers') do 
          expect(page).to have_content("1.#{whitney.first_name} #{whitney.last_name} #{whitney.num_succesful_transactions} purchases")
          expect(page).to have_content("2.#{alaina.first_name} #{alaina.last_name} #{alaina.num_succesful_transactions} purchases")
          expect(page).to have_content("3.#{eddie.first_name} #{eddie.last_name} #{eddie.num_succesful_transactions} purchases")
          expect(page).to have_content("4.#{polina.first_name} #{polina.last_name} #{polina.num_succesful_transactions} purchases")
          expect(page).to have_content("5.#{ryan.first_name} #{ryan.last_name} #{ryan.num_succesful_transactions} purchases")
        end
      end

      it "Then I see a section for Items Ready to Ship" do
        visit "/merchants/#{jewlery_city.id}/dashboard"

        expect(page).to have_content("Items Ready to Ship")
      end

      it " In that section I see a list of the names of all of my items that
      have been ordered and have not yet been shipped" do

      visit "/merchants/#{jewlery_city.id}/dashboard"

      within('#ready_to_ship') do
        expect(page).to have_content("Gold Earrings")
        expect(page).to have_content("Gold Studded Bracelet")
        expect(page).to have_content("Dainty Ankley")
        expect(page).to_not have_content("Stackable Gold Rings")
        expect(page).to_not have_content("Silver Necklace")
        end
      end

      it "And next to each Item I see the id of the invoice that ordered my item" do

      visit "/merchants/#{jewlery_city.id}/dashboard"

      within('#ready_to_ship') do
        expect(page).to have_content("Gold Earrings - Invoice ##{alaina_invoice1.id}")
        expect(page).to have_content("Gold Earrings - Invoice ##{alaina_invoice2.id}")
        expect(page).to have_content("Gold Earrings - Invoice ##{alaina_invoice3.id}")
        expect(page).to have_content("Gold Earrings - Invoice ##{alaina_invoice4.id}")
        expect(page).to have_content("Gold Studded Bracelet - Invoice ##{eddie_invoice1.id}")
        expect(page).to have_content("Gold Studded Bracelet - Invoice ##{eddie_invoice2.id}")
        expect(page).to have_content("Gold Studded Bracelet - Invoice ##{eddie_invoice3.id}")
        expect(page).to have_content("Dainty Ankley - Invoice ##{polina_invoice1.id}")
        expect(page).to have_content("Dainty Ankley - Invoice ##{polina_invoice2.id}")
        expect(page).to_not have_content("Dainty Ankley - Invoice ##{alaina_invoice1.id}")
        expect(page).to_not have_content("Dainty Ankley - Invoice ##{ryan_invoice1.id}")
        end
      end

      it "And each invoice id is a link to my merchant's invoice show page" do
        visit "/merchants/#{jewlery_city.id}/dashboard"

        within('#ready_to_ship') do
          expect(page).to have_link("#{alaina_invoice1.id}")
          expect(page).to have_link("#{alaina_invoice2.id}")
          expect(page).to have_link("#{alaina_invoice3.id}")
          expect(page).to have_link("#{alaina_invoice4.id}")
          expect(page).to have_link("#{eddie_invoice1.id}")
          expect(page).to have_link("#{eddie_invoice2.id}")
          expect(page).to have_link("#{polina_invoice1.id}")
          expect(page).to have_link("#{polina_invoice2.id}")
          expect(page).to have_link("#{alaina_invoice4.id}")
          expect(page).to_not have_link("#{ryan_invoice1.id}")
          
          click_on("#{alaina_invoice1.id}")
          expect(current_path).to eq("/merchants/#{jewlery_city.id}/invoices/#{alaina_invoice1.id}")
          end
      end

      it "next to each item in the ready to ship section I see the date that invoice was created formatted correctly and ordered from oldest to newest" do
        visit "/merchants/#{jewlery_city.id}/dashboard"
        within('#ready_to_ship') do
save_and_open_page
          expect(page).to have_content("Monday, July 18, 2019")
        end
      end

      it "invoices are ordered from oldest to newest" 


    end
  end
end

