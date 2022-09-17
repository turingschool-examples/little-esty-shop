require 'rails_helper'
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

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


  describe 'class methods' do
    describe '#incomplete_invoices' do
     it 'can return the invoices that have a status of in progress' do 

      expect(Invoice.incomplete_invoices).to eq([alaina_invoice2, leah_invoice2])
     end
    end
  end

  describe 'instance methods' do
    # describe '#find_invoice_customer' do

    #   let!(:jewlery_city) { Merchant.create!(name: "Jewlery City Merchant")}

    #   let!(:gold_earrings) { jewlery_city.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
    #   let!(:silver_necklace) { jewlery_city.items.create!(name: "Silver Necklace", description: "An everyday wearable silver necklace", unit_price: 220000) }

    #   let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}

    #   let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed")}

    #   let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
    #   let!(:alainainvoice1_itemsilver_necklace) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: silver_necklace.id, quantity: 4, unit_price: 1300, status:"packaged" )}

    #   it 'returns the customer object related to that invoice' do
    #     expect(alaina_invoice1.find_invoice_customer)
    #   end
    # end
  end

end