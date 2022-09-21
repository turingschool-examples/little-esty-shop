require 'rails_helper'

RSpec.describe 'Admin Merchant Index', type: :feature do
  # let blocks
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Peanut Caramel Chews", unit_price: 1500) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Cholately Waffles of Deliciousness", unit_price: 900) }
  let!(:hummus) { carly.items.create!(name: "Hummus", description: "Creamy Hummus", unit_price: 1200) }

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
  let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
  let!(:alaina_invoice3) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice4) { alaina.invoices.create!(status: "completed")}
  let!(:alaina_invoice5) { alaina.invoices.create!(status: "completed")}
  let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed")}
  let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed")}
  let!(:eddie_invoice3) { eddie.invoices.create!(status: "completed")}
  let!(:ryan_invoice1) { ryan.invoices.create!(status: "completed")}
  let!(:ryan_invoice2) { ryan.invoices.create!(status: "completed")}
  let!(:polina_invoice1) { polina.invoices.create!(status: "completed")}
  let!(:polina_invoice2) { polina.invoices.create!(status: "cancelled")}
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
  let!(:alainainvoice2_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: gold_earrings.id, quantity: 40, unit_price: 1500, status:"shipped" )}
  let!(:alainainvoice3_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice3.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1600, status:"shipped" )}
  let!(:alainainvoice4_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice4.id, item_id: gold_earrings.id, quantity: 4, unit_price: 2400, status:"shipped" )}
  let!(:alainainvoice5_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice5.id, item_id: gold_earrings.id, quantity: 243, unit_price: 27000, status:"shipped" )}

  let!(:whitneyinvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice1.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice2_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice2.id, item_id: silver_necklace.id, quantity: 31, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice3_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice3.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice4_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice4.id, item_id: silver_necklace.id, quantity: 10, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice5_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice5.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
  let!(:whitneyinvoice6_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice6.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"shipped" )}


  let!(:eddie_invoice1_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice1.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2199, status:"shipped" )}
  let!(:eddie_invoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice2.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 2700, status:"shipped" )}
  let!(:eddie_invoice3_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: eddie_invoice3.id, item_id: studded_bracelet.id, quantity: 3, unit_price: 10299, status:"shipped" )}

  let!(:polina_invoice1_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: polina_invoice1.id, item_id: dainty_anklet.id, quantity: 6, unit_price: 270, status:"shipped" )}
  let!(:polina_invoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: polina_invoice2.id, item_id: dainty_anklet.id, quantity: 1, unit_price: 270, status:"shipped" )}
  
  describe 'As an admin, when I visit admin merchants index' do
    before(:each) do
      visit admin_merchants_path
    end

    it 'shows the name of each merchant in the system' do 
      merchants = Merchant.all
      merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_content(merchant.name)
        end
      end
    end

    it 'links to the show page for respective merchant' do
      merchants = Merchant.all
      merchants.each do |merchant|
        within "#merchant-#{merchant.id}" do
          expect(page).to have_link(merchant.name)
          click_link(merchant.name)
        end
        expect(current_path).to eq("/admin/merchants/#{merchant.id}")
        visit admin_merchants_path
      end
    end

    it 'has a link to create a new merchant' do
      expect(page).to have_link("Create New Merchant")
      click_link "Create New Merchant"
      expect(current_path).to eq(new_admin_merchant_path)
    end

    describe 'enable/disable' do
      it 'next to each merchant name I see a button to disable or enable that merchant.' do
        merchants = Merchant.all
        merchants.each do |merchant|
          within "#merchant-#{merchant.id}" do
            expect(page).to have_button
            expect(page).to have_button("Enable").or have_button("Disable")
            expect(page).to have_button("Enable") unless merchant.enabled
            expect(page).to have_button("Disable") if merchant.enabled
          end
        end
      end

      it 'When I click this button Then I am redirected back to the admin merchants index And I see that the merchants status has changed' do
        merchants = Merchant.all
        merchants.each do |merchant|
          within "#merchant-#{merchant.id}" do
            expect(page).to have_button("Enable")
            click_button "Enable"
            expect(current_path).to eq(admin_merchants_path)
            expect(page).to have_button("Disable")
            click_button "Disable"
            expect(current_path).to eq(admin_merchants_path)
            expect(page).to have_button("Enable")
          end
        end
      end

      describe 'status grouping' do
        let!(:doghats) { Merchant.create!(name: "Hats for Dogs", enabled: true) }
        let!(:hummus_sculpt) { Merchant.create!(name: "Hummus Sculptures", enabled: true) }
        
        before(:each) {refresh}

        it 'groups merchants by enabled status' do 
          within('#enabled_merchants') do
            expect(page).to have_content(doghats.name)
            expect(page).to have_content(hummus_sculpt.name)

            expect(page).to_not have_content(carly.name)
            expect(page).to_not have_content(jewlery_city.name)
          end

          within('#disabled_merchants') do
            expect(page).to_not have_content(doghats.name)
            expect(page).to_not have_content(hummus_sculpt.name)

            expect(page).to have_content(carly.name)
            expect(page).to have_content(jewlery_city.name)
          end
        end

        describe 'for each enabled merchant' do
          it 'has a button to disable and regroup merchant' do
            en_merchants = Merchant.where('enabled = ?', true)
            en_merchants.each do |merchant|
              within('#enabled_merchants') do
                expect(page).to have_content(merchant.name)
              end

              within "#merchant-#{merchant.id}" do
                click_button "Disable"
              end

              within('#disabled_merchants') do
                expect(page).to have_content(merchant.name)
              end
            end
          end
        end

        describe 'for each disabled merchant' do
          it 'has a button to enable and regroup merchant' do
            dis_merchants = Merchant.where('enabled = ?', false)
            dis_merchants.each do |merchant|
              within('#disabled_merchants') do
                expect(page).to have_content(merchant.name)
              end

              within "#merchant-#{merchant.id}" do
                click_button "Enable"
              end

              within('#enabled_merchants') do
                expect(page).to have_content(merchant.name)
              end
            end
          end
        end
      end
    end

    describe 'Top 5 merchants by revenue section:' do
      let!(:doghats) { Merchant.create!(name: "Hats for Dogs", enabled: true) }
      let!(:hummus_sculpt) { Merchant.create!(name: "Hummus Sculptures", enabled: true) }
      let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}
      let!(:tersela) { Merchant.create!(name: "Tersela")}

      let!(:boxer) { doghats.items.create!(name: "Boxer Bowler", description: "Now with convienent earholes", unit_price: 16000, enabled: true) }
      let!(:trombone) { hummus_sculpt.items.create!(name: "Tahini Trombone", description: "Dont buy this", unit_price: 5000, enabled: true) }
      let!(:pita) { hummus_sculpt.items.create!(name: "Picked Pita", description: "Yummy", unit_price: 700, enabled: true) }
      let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000, enabled: true) }
      let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000, enabled: true) }
      let!(:cyber_bus) { tersela.items.create!(name: "Cyberbus", description: "It may be electric, but it still only holds one person!", unit_price: 8900000, enabled: true) }

      let!(:alainainvoice1_itempeanut) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: peanut.id, quantity: 1, unit_price: 1500, status:"packaged" )}
      let!(:alainainvoice1_itemboxer) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: boxer.id, quantity: 4, unit_price: 16000, status:"packaged" )}
      let!(:alainainvoice1_itemtrombone) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: trombone.id, quantity: 4, unit_price: 5000, status:"packaged" )}
      let!(:alainainvoice1_itempita) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: pita.id, quantity: 4, unit_price: 700, status:"packaged" )}
      let!(:alainainvoice1_itemskooter) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: skooter.id, quantity: 4, unit_price: 12000, status:"packaged" )}
      let!(:alainainvoice1_itemrider) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: rider.id, quantity: 4, unit_price: 220000, status:"packaged" )}

      before(:each) {refresh}

      it 'I see the names of the top 5 merchants by total revenue generated' do
        within '#top_5_merchants' do
          expect(jewlery_city.name).to appear_before(bmv.name)
          expect(bmv.name).to appear_before(doghats.name)
          expect(doghats.name).to appear_before(hummus_sculpt.name)
          expect(hummus_sculpt.name).to appear_before(carly.name)
        end
      end

      it 'and each name links to the merchant show page' do
        top_merch = Merchant.merchants_top_5
        within '#top_5_merchants' do
          top_merch.each do |merch|
            within "#top-merchant-#{merch.id}" do
              expect(page).to have_link(merch.name)
              click_link(merch.name)
            end
            expect(current_path).to eq(admin_merchant_path(merch))
            visit admin_merchants_path
          end
        end
      end

      it 'and I see the total revenue generated next to each merchant name' do
        within '#top_5_merchants' do
          top_merch = Merchant.merchants_top_5
          top_merch.each do |merch|
            within "#top-merchant-#{merch.id}" do
              expect(page).to have_content("#{merch.name} - $#{'%.2f' % (merch.revenue)} in revenue")
            end
          end
        end
      end
      
      it 'and I there I see the merchants best day of sales' do
        within '#top_5_merchants' do
          top_merch = Merchant.merchants_top_5
          top_merch.each do |merch|
            within("#top-merchant-#{merch.id}") do
              expect(page).to have_content("Top sales date for #{merch.name} was #{merch.best_sales_date}")
            end
          end
        end
      end
    end
  end
end
