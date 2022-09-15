require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo")}
  let!(:bmv) { Merchant.create!(name: "Bavarian Motor Velocycles")}

  let!(:licorice) { carly.items.create!(name: "Licorice Funnels", description: "Some stuff", unit_price: 1200, enabled: true) }
  let!(:peanut) { carly.items.create!(name: "Peanut Bronzinos", description: "Some stuff", unit_price: 1500, enabled: true) }
  let!(:choco_waffle) { carly.items.create!(name: "Chocolate Waffles Florentine", description: "Some stuff", unit_price: 900, enabled: false) }
  let!(:hummus) { carly.items.create!(name: "Hummus Snocones", description: "Some stuff", unit_price: 1300, enabled: false) }
  let!(:grobles) { carly.items.create!(name: "Kasegrobles", description: "Some stuff", unit_price: 1400, enabled: true) }
  let!(:knutels) { carly.items.create!(name: "Schmooknutels", description: "Some stuff", unit_price: 800, enabled: true) }
  let!(:brontos) { carly.items.create!(name: "Walder Brontos", description: "Some stuff", unit_price: 700, enabled: true) }
  let!(:grongos) { carly.items.create!(name: "Funky Grongos", description: "Some stuff", unit_price: 600, enabled: true) }

  let!(:skooter) { bmv.items.create!(name: "Hollenskooter", description: "Some stuff", unit_price: 12000, enabled: true) }
  let!(:rider) { bmv.items.create!(name: "Hosenpfloofer", description: "Some stuff", unit_price: 220000, enabled: true) }

  let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
  let!(:whitney) { Customer.create!(first_name: "Whitney", last_name: "Gains")}
  
  let!(:invoice1) { alaina.invoices.create!(status: "completed")}
  let!(:invoice2) { alaina.invoices.create!(status: "in_progress")}
  let!(:invoice3) { alaina.invoices.create!(status: "completed")}
  let!(:invoice4) { alaina.invoices.create!(status: "completed")}
  let!(:invoice5) { alaina.invoices.create!(status: "completed")}
  let!(:invoice6) { alaina.invoices.create!(status: "completed")}
  let!(:invoice7) { whitney.invoices.create!(status: "completed")}
  let!(:invoice8) { whitney.invoices.create!(status: "completed")}
  let!(:invoice9) { whitney.invoices.create!(status: "completed")}
  let!(:invoice10) { whitney.invoices.create!(status: "completed")}

  let!(:transaction1) { invoice1.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction2) { invoice2.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction3) { invoice3.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction4) { invoice4.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction5) { invoice5.transactions.create!(credit_card_number: "4654405418249632", result: "failed")}
  let!(:transaction6) { invoice6.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction7) { invoice7.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction8) { invoice8.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction9) { invoice9.transactions.create!(credit_card_number: "4654405418249632", result: "success")}
  let!(:transaction10) { invoice10.transactions.create!(credit_card_number: "4654405418249632", result: "failed")}

  let!(:invoice_item1) { InvoiceItem.create!(invoice_id: invoice1.id, item_id: licorice.id, quantity: 4, unit_price: 2000, status:"packaged" )}
  let!(:invoice_item2) { InvoiceItem.create!(invoice_id: invoice2.id, item_id: peanut.id, quantity: 6, unit_price: 2300, status:"packaged")}
  let!(:invoice_item3) { InvoiceItem.create!(invoice_id: invoice3.id, item_id: grobles.id, quantity: 7, unit_price: 1900, status:"packaged")}
  let!(:invoice_item4) { InvoiceItem.create!(invoice_id: invoice4.id, item_id: knutels.id, quantity: 1, unit_price: 1900, status:"packaged")}
  let!(:invoice_item5) { InvoiceItem.create!(invoice_id: invoice5.id, item_id: brontos.id, quantity: 2, unit_price: 1000, status:"packaged")}
  let!(:invoice_item6) { InvoiceItem.create!(invoice_id: invoice6.id, item_id: grongos.id, quantity: 3, unit_price: 1800, status:"packaged")}
  let!(:invoice_item7) { InvoiceItem.create!(invoice_id: invoice7.id, item_id: grobles.id, quantity: 8, unit_price: 1900, status:"packaged")}
  let!(:invoice_item8) { InvoiceItem.create!(invoice_id: invoice8.id, item_id: grongos.id, quantity: 10, unit_price: 1800, status:"packaged")}
  let!(:invoice_item9) { InvoiceItem.create!(invoice_id: invoice9.id, item_id: licorice.id, quantity: 9, unit_price: 2000, status:"packaged")}
  let!(:invoice_item10) { InvoiceItem.create!(invoice_id: invoice10.id, item_id: peanut.id, quantity: 4, unit_price: 2300, status:"packaged")}

  describe 'merchant items index page' do
    it 'lists the names of all items' do
      visit merchant_items_path(carly)

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
        it 'lists the top 5 items by revenue generated' do
          visit merchant_items_path(carly)

          within("#top-five") do
            expect(item).to appear_before(item)
            expect(item).to appear_before(item)
            expect(item).to appear_before(item)
            expect(item).to appear_before(item)
            expect(item).to appear_before(item)
          end
        end
      end
    end
  end
end

