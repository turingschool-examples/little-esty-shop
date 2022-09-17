require 'rails_helper'

RSpec.describe "merchant's invoices index", type: :feature do
  describe 'As a merchant' do
    describe "When I visit my merchant's invoices index (/merchants/merchant_id/invoices)" do

      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200, enabled: true) }
      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
      let!(:studded_bracelet) { jewlery_city.items.create!(name: "Gold Studded Bracelet", description: "A bracet to make others jealous", unit_price: 2900) } #no one is buying the studded bracelet so it should not appear in the tests

      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
      let!(:whitney) { Customer.create!(first_name: "Whitney", last_name: "Gains")}

      let!(:whitney_invoice1) { whitney.invoices.create!(status: "completed", created_at: "2012-01-30 14:54:09" )}
      let!(:whitney_invoice2) { whitney.invoices.create!(status: "completed")}
      let!(:whitney_invoice3) { whitney.invoices.create!(status: "completed")}
      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed", created_at: "2020-01-30 14:54:09")}
      let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
      let!(:alaina_invoice3) { alaina.invoices.create!(status: "completed")}
      let!(:alaina_invoice4) { alaina.invoices.create!(status: "completed")}


      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice2_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice2.id, item_id: gold_earrings.id, quantity: 40, unit_price: 1500, status:"shipped" )}
      let!(:alainainvoice3_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice3.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1600, status:"shipped" )}
      let!(:alainainvoice4_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice4.id, item_id: licorice.id, quantity: 4, unit_price: 2400, status:"shipped" )}
      let!(:whitneyinvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice1.id, item_id: silver_necklace.id, quantity: 3, unit_price: 270, status:"packaged" )}
      let!(:whitneyinvoice2_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice2.id, item_id: silver_necklace.id, quantity: 31, unit_price: 270, status:"shipped" )}
      let!(:whitneyinvoice3_itemsilver_necklace) { InvoiceItem.create!(invoice_id: whitney_invoice3.id, item_id: silver_necklace.id, quantity: 1, unit_price: 270, status:"shipped" )}
      


      it "Then I see all of the invoices that include at least one of my merchant's items And for each invoice I see its id
      And each id links to the merchant invoice show page" do
        visit merchant_invoices_path(jewlery_city)
        within('#relevant_invoices') do 
          expect(page).to_not have_content(alaina_invoice4.id)
          expect(page).to have_content(alaina_invoice1.id)
          expect(page).to have_content(alaina_invoice2.id)
          expect(page).to have_content(alaina_invoice3.id)
          expect(page).to have_content(whitney_invoice1.id)
          expect(page).to have_content(whitney_invoice2.id)
          expect(page).to have_content(whitney_invoice3.id)
        end

      end

    end
  end
end
