require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should define_enum_for(:status).with_values(["packaged", "pending", "shipped"])}
  end

  describe 'class methods' do
    let!(:merchant1) {Merchant.create!(name: "Brian's Beads")}

    let!(:customer1) { Customer.create!(first_name: "Britney", last_name: "Spears")}
    let!(:customer2) { Customer.create!(first_name: "Bob", last_name: "Smith")}
    let!(:customer3) { Customer.create!(first_name: "Bill", last_name: "Johnson")}
    let!(:customer4) { Customer.create!(first_name: "Boris", last_name: "Nelson")}
    let!(:customer5) { Customer.create!(first_name: "Barbara", last_name: "Hilton")}
    let!(:customer6) { Customer.create!(first_name: "Bella", last_name: "Thomas")}

    let!(:invoice1) { customer1.invoices.create!(status: 2) }
    let!(:invoice2) { customer1.invoices.create!(status: 2) }
    let!(:invoice3) { customer2.invoices.create!(status: 2) }
    let!(:invoice4) { customer2.invoices.create!(status: 2) }
    let!(:invoice5) { customer3.invoices.create!(status: 2) }
    let!(:invoice6) { customer3.invoices.create!(status: 2) }
    let!(:invoice7) { customer4.invoices.create!(status: 2) }
    let!(:invoice8) { customer5.invoices.create!(status: 2) }
    let!(:invoice9) { customer5.invoices.create!(status: 2) }
    let!(:invoice10) { customer6.invoices.create!(status: 2) }
    let!(:invoice11) { customer6.invoices.create!(status: 2) }

    let!(:item1) { merchant1.items.create!(name: "water bottle", description: "24oz metal container for water", unit_price: 8) }    
    let!(:item2) { merchant1.items.create!(name: "rubber duck", description: "toy for bath", unit_price: 1) }    
    let!(:item3) { merchant1.items.create!(name: "lamp", description: "12 inch desk lamp", unit_price: 16) }    
    let!(:item4) { merchant1.items.create!(name: "wireless mouse", description: "wireless computer mouse for mac", unit_price: 40) }    
    let!(:item5) { merchant1.items.create!(name: "chapstick", description: "coconut flavor chapstick", unit_price: 2) }

    let!(:transaction1) {invoice1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction2) {invoice2.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction3) {invoice3.transactions.create!(credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction4) {invoice4.transactions.create!(credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
   
    let!(:transaction5) {invoice5.transactions.create!(credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction6) {invoice6.transactions.create!(credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
   
    let!(:transaction14) {invoice7.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
    let!(:transaction15) {invoice7.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction7) {invoice8.transactions.create!(credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction8) {invoice9.transactions.create!(credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    
    let!(:transaction9) {invoice10.transactions.create!(credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
    let!(:transaction10) {invoice10.transactions.create!(credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
    let!(:transaction11) {invoice11.transactions.create!(credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }

    describe '::invoice_items_not_shipped' do
      before(:each) do
        InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
        InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 7, unit_price: item2.unit_price, status: 1)
        InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 1, unit_price: item3.unit_price, status: 2)
        InvoiceItem.create!(invoice_id: invoice3.id, item_id: item3.id, quantity: 6, unit_price: item3.unit_price, status: 2)
        InvoiceItem.create!(invoice_id: invoice4.id, item_id: item4.id, quantity: 9, unit_price: item4.unit_price, status: 1)
        InvoiceItem.create!(invoice_id: invoice5.id, item_id: item5.id, quantity: 4, unit_price: item5.unit_price, status: 0)
        InvoiceItem.create!(invoice_id: invoice5.id, item_id: item4.id, quantity: 7, unit_price: item4.unit_price, status: 0)
        InvoiceItem.create!(invoice_id: invoice6.id, item_id: item4.id, quantity: 8, unit_price: item4.unit_price, status: 2)
        InvoiceItem.create!(invoice_id: invoice7.id, item_id: item3.id, quantity: 6, unit_price: item3.unit_price, status: 1)
        InvoiceItem.create!(invoice_id: invoice8.id, item_id: item2.id, quantity: 3, unit_price: item2.unit_price, status: 0)
        InvoiceItem.create!(invoice_id: invoice9.id, item_id: item1.id, quantity: 2, unit_price: item1.unit_price, status: 2)
        InvoiceItem.create!(invoice_id: invoice10.id, item_id: item2.id, quantity: 1, unit_price: item2.unit_price, status: 1)
        InvoiceItem.create!(invoice_id: invoice10.id, item_id: item5.id, quantity: 3, unit_price: item5.unit_price, status: 0)
        InvoiceItem.create!(invoice_id: invoice11.id, item_id: item3.id, quantity: 2, unit_price: item3.unit_price, status: 0)
      end

      it 'lists the ids of all invoices that have items that have not shipped' do
        expect(InvoiceItem.invoice_items_not_shipped).to match_array([invoice1.id, invoice2.id, invoice4.id, invoice5.id, invoice7.id, invoice8.id, invoice10.id, invoice11.id])

        InvoiceItem.create!(invoice_id: invoice3.id, item_id: item1.id, quantity: 2, unit_price: item3.unit_price, status: 0)

        expect(InvoiceItem.invoice_items_not_shipped).to match_array([invoice1.id, invoice2.id, invoice3.id, invoice4.id, invoice5.id, invoice7.id, invoice8.id, invoice10.id, invoice11.id])
      end
    end
  end
end
