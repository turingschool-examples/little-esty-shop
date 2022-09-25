require 'rails_helper'
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'class methods' do
    describe '#incomplete_invoices' do
      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
      let!(:eddie) { Customer.create!(first_name: "Eddie", last_name: "Young")}
      let!(:leah) { Customer.create!(first_name: "Leah", last_name: "Anderson")}
      let!(:polina) { Customer.create!(first_name: "Polina", last_name: "Eisenberg")}
    
      let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
      let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed", created_at: "2000-01-30 14:54:09")}
      let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed")}
      let!(:polina_invoice1) { polina.invoices.create!(status: "completed")}
      let!(:polina_invoice2) { polina.invoices.create!(status: "cancelled")}
      let!(:leah_invoice1) { leah.invoices.create!(status: "cancelled")}
      let!(:leah_invoice2) { leah.invoices.create!(status: "in_progress")}
     it 'can return the invoices that have a status of in progress' do 

      expect(Invoice.incomplete_invoices).to eq([alaina_invoice2, leah_invoice2])
     end
    end
  end

  describe 'instance methods' do
    describe '#find_relevant_invoices' do
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200, enabled: true) }
      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }

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

     it 'can return the invoices where the merchant has at least one item on that invoice' do 

      expect(jewlery_city.find_relevant_invoices).to include(alaina_invoice1, alaina_invoice2, alaina_invoice3, whitney_invoice1, whitney_invoice2, whitney_invoice3)
      expect(jewlery_city.find_relevant_invoices).to_not include(alaina_invoice4)
     end
    end

    describe '#merchant_items' do
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200, enabled: true) }

      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}

      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}

      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice1_itemglicorice) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: licorice.id, quantity: 4, unit_price: 1300, status:"packaged" )}


      it 'takes a merchant as an arg and returns an array of items from that merchant which appear on the invoice' do
        expect(alaina_invoice1.merchant_items(jewlery_city)).to include(gold_earrings, silver_necklace)
        expect(alaina_invoice1.merchant_items(jewlery_city)).to_not include(licorice)
      end
    end


    describe '#calculate_invoice_revenue(merchant)' do
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }
      let!(:licorice) { carly_silo.items.create!(name: "Licorice Funnels", description: "Licorice Balls", unit_price: 1200, enabled: true) }

      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}

      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}

      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice1_itemglicorice) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: licorice.id, quantity: 4, unit_price: 1300, status:"packaged" )}

      it 'takes a merchant as an arg and returns the total amount of revenue that invoice generated for that merchant' do
        expect(alaina_invoice1.calculate_invoice_revenue).to eq(15600)
      end
    end

    describe '#calculate_discounted_invoice_revenue' do
      let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:carly_silo) { Merchant.create!(name: "Carly Simon's Candy Silo")}

      let!(:jcity_discount1) {jewlery_city.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)}
      let!(:jcity_discount2) {jewlery_city.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)}
      
      let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 22000) }

      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}

      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 12, unit_price: 1300, status:"packaged" )}
      let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 15, unit_price: 1300, status:"packaged" )}


      it 'can calculate the invoice revenue not particular to any merchant' do
        expect(alaina_invoice1.calculate_invoice_revenue).to eq(35100)
      end

      it 'can calculate the invoice revenue for the merchant from this invoice' do
        expect(alaina_invoice1.calculate_revenue_for(jewlery_city)).to eq(35100)
      end

      it 'can calculate the invoice revenue for the merchant from this invoice' do
        expect(alaina_invoice1.calculate_discounted_invoice_revenue(jewlery_city)).to eq(26130)
      end
      
    end

  end

end
