require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe "instance methods" do
    it "#invoice_customer" do
      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      invoice1 = customer1.invoices.create!(status: "cancelled")

      expect(invoice1.invoice_customer).to eq("Leanne Braun")
    end

    it "#total_revenue" do
      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      invoice1 = customer1.invoices.create!(status: "in progress")

      merchant1 = Merchant.create!(name: "REI")
      item1 = merchant1.items.create!(name: "Boots", description: "You wear them!", unit_price: 213)
      item2 = merchant1.items.create!(name: "Jacket", description: "Keeps you warm!", unit_price: 144)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 195, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 3, unit_price: 130, status: "packaged")

      expect(invoice1.total_revenue).to eq(1365)
    end
  end


    describe 'class methods' do
      let!(:merchant_1) {Merchant.create!(name: "REI")}

      let!(:customer1) { Customer.create!(first_name: "Leanne", last_name: "Braun") }

      let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: '2012-03-21 14:53:59') }
      let!(:invoice2) { customer1.invoices.create!(status: 2, created_at: '2012-03-23 14:53:59') }
      let!(:invoice3) { customer1.invoices.create!(status: 2, created_at: '2012-03-24 14:53:59') }
      let!(:invoice4) { customer1.invoices.create!(status: 2, created_at: '2012-03-25 14:53:59') }

      let!(:item1) {merchant_1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 135)}
      let!(:item2) {merchant_1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 219.99)}
      let!(:item3) {merchant_1.items.create!(name: "Backpack", description: "Can carry all your hiking snacks", unit_price: 99)}

      let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 130, status: "shipped") }
      let!(:invoice_item2) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 130, status: "pending") }
      let!(:invoice_item3) { InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 8, unit_price: 220, status: "packaged") }
      let!(:invoice_item4) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 1, unit_price: 100, status: "shipped") }
      let!(:invoice_item5) { InvoiceItem.create!(item_id: item3.id, invoice_id: invoice4.id, quantity: 1, unit_price: 100, status: "packaged") }

    describe '.incomplete_invoices' do
      it 'returns the invoices with items that have not yet been shipped, ordered from oldest to newest' do
        expect(Invoice.incomplete_invoices).to eq([invoice1, invoice2, invoice4])
      end
    end
  end
end
