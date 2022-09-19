require 'rails_helper'

RSpec.describe 'admin invoice show' do
    let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
    let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

    let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
    let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
    let!(:studded_bracelet) { jewlery_city.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) } #no one is buying the studded bracelet so it should not appear in the tests
    let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200, enabled: true) }
    
    let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}

    let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}
    let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}

    # alaina_invoice1 should have, from Jewelry, gold earrings and silver necklace, NOT studded bracelet. should also have licorice id, but that should not be shown for this merchant
    let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
    let!(:alainainvoice9_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 6, unit_price: 1111, status:"shipped" )}

    let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 7, unit_price: 1500, status:"packaged" )}

    let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 4, unit_price: 1300, status:"packaged" )}

    let!(:alainainvoice1_itemslicorice) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: licorice.id, quantity: 4, unit_price: 1300, status:"packaged" )}

    #this invoice contains an item belonging to this merchant, but no info should be should on invoice1 show page
    let!(:alainainvoice2_itemstudded_bracelet) { InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: studded_bracelet.id, quantity: 40, unit_price: 1500, status:"shipped" )}

    it 'shows all invoice info' do
        visit admin_invoice_path(alaina_invoice1)
        expect(page).to have_content("Invoice ##{alaina_invoice1.id}")
        expect(page).to have_content("Status: #{alaina_invoice1.status}")
        expect(page).to have_content("Created at: #{alaina_invoice1.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Customer: #{alaina.name}")
        expect(page).to_not have_content("Invoice ##{alaina_invoice2.id}")
        expect(page).to have_content("Total Revenue: #{alaina_invoice1.calculate_invoice_revenue}")
    end

    describe 'invoice items' do
        it 'shows all invoice items' do
            visit admin_invoice_path(alaina_invoice1)
            within "#invoice_items" do
                expect(page).to have_content(alainainvoice1_itemgold_earrings.item.name)
                expect(page).to have_content(alainainvoice1_itemsilver_necklace.item.name)
                expect(page).to_not have_content(alainainvoice2_itemstudded_bracelet.item.name)
            end
        end

        it 'shows all item info' do
            visit admin_invoice_path(alaina_invoice1)
            expect(page).to have_content(alainainvoice1_itemgold_earrings.item.name)
            expect(page).to have_content("Quantity: #{alainainvoice1_itemgold_earrings.quantity}")
            expect(page).to have_content("Sale Price: #{alainainvoice1_itemgold_earrings.unit_price}")
            expect(page).to have_content("Status: #{alainainvoice1_itemgold_earrings.status}")
            expect(page).to_not have_content(alainainvoice2_itemstudded_bracelet.unit_price)
        end
    end
end