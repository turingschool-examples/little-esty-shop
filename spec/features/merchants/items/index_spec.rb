require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200, enabled: true) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500, enabled: true) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900, enabled: false) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200, enabled: false) }

  let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000, enabled: true) }
  let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000, enabled: true) }

  let!(:alaina) { Customer.create!(first_name: “Alaina”, last_name: “Kneiling”)}
  let!(:whitney) { Customer.create!(first_name: “Whitney”, last_name: “Gains”)}

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

  let!(:alaina_invoice1_transaction) { alaina_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice2_transaction) { alaina_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice3_transaction) { alaina_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice4_transaction) { alaina_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:alaina_invoice5_transaction) { alaina_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice1_transaction) { whitney_invoice1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice2_transaction) { whitney_invoice2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice3_transaction) { whitney_invoice3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice4_transaction) { whitney_invoice4.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice5_transaction) { whitney_invoice5.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}
  let!(:whitney_invoice6_transaction) { whitney_invoice6.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")}

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

  describe 'merchant items index page' do
    it 'lists the names of all items' do
      visit merchant_items_path(carly)
      save_and_open_page
      expect(page).to have_content(licorice.name)
      expect(page).to have_content(peanut.name)
      expect(page).to have_content(choco_waffle.name)
      expect(page).to have_content(hummus.name)
    end

    it 'does not list the names of other merchant items' do
      visit merchant_items_path(carly)
      
      expect(page).to_not have_content(skooter.name)
      expect(page).to_not have_content(rider.name)
    end

    it 'has sections for enabled and disabled items' do
      visit merchant_items_path(carly)

      within("#enabled_items") do
        expect(page).to have_content(licorice.name)
        expect(page).to_not have_content(hummus.name)
      end

      within("#disabled_items") do
        expect(page).to have_content(hummus.name)
        expect(page).to_not have_content(licorice.name)
      end
    end
    
    describe 'for each enabled item' do
      it 'has a button to disable item' do
        visit merchant_items_path(carly)

        within("#enabled_items") do
          expect(page).to have_content(licorice.name)
        end
  
        within("#disabled_items") do
          expect(page).to_not have_content(licorice.name)
        end

        within("#item-#{licorice.id}") do
          click_on "Disable"
        end

        expect(current_path).to eq(merchant_items_path(carly))

        within("#enabled_items") do
          expect(page).to_not have_content(licorice.name)
        end
  
        within("#disabled_items") do
          expect(page).to have_content(licorice.name)
        end
      end
    end

    describe 'for each disabled item' do
      it 'has a button to enable item' do
        visit merchant_items_path(carly)

        within("#disabled_items") do
          expect(page).to have_content(hummus.name)
        end
  
        within("#enabled_items") do
          expect(page).to_not have_content(hummus.name)
        end

        within("#item-#{hummus.id}") do
          click_on "Enable"
        end

        expect(current_path).to eq(merchant_items_path(carly))

        within("#disabled_items") do
          expect(page).to_not have_content(hummus.name)
        end
  
        within("#enabled_items") do
          expect(page).to have_content(hummus.name)
        end
      end
    end

    describe 'it lists the 5 most popular items' do
      describe 'and the total revenue each item generates' do
      
      
      # let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200, enabled: true) }
      # let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500, enabled: true) }
      # let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900, enabled: false) }
      # let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1200, enabled: false) 


        # it 'lists the top 5 items by revenue generated' do
        #   visit merchant_items_path(carly)

          

        #   within("#top_five") do
        #     expect(item).to appear_before(item)
        #     expect(item).to appear_before(item)
        #     expect(item).to appear_before(item)
        #     expect(item).to appear_before(item)
        #     expect(item).to appear_before(item)
        #   end
        # end
      end
    end
  end
end

# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant

