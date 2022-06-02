require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    let!(:merchant_1) {Merchant.create!(name: "REI")}

    let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }

    let!(:invoice1) { customer1.invoices.create!(status: 2) }
    let!(:invoice2) { customer1.invoices.create!(status: 2) }
    let!(:invoice3) { customer1.invoices.create!(status: 2) }

    let!(:item1) {merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)}
    let!(:item2) {merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)}
    let!(:item3) {merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)}

    let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
    let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
    let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
    let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 1, unit_price: 100, status: "shipped") }

    describe '.incomplete_invoice_ids' do
      it 'returns the ids of invoices with items that have not yet been shipped (are pending or packaged)' do
        expect(InvoiceItem.incomplete_invoice_ids).to include(invoice2.id)
        expect(InvoiceItem.incomplete_invoice_ids).to include(invoice1.id)
        expect(InvoiceItem.incomplete_invoice_ids).to_not include(invoice3.id)
      end
    end
  end


end
