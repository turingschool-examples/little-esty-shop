require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions)}
  end

  describe 'enum validation' do
    it { should define_enum_for(:status).with([:in_progress, :cancelled, :completed])}
  end

  describe 'instance methods' do
    describe '#customer_name' do
      it 'displays a customers first and last name' do
        merchant1 = create(:merchant)
        customer = create(:customer, first_name: 'Bob', last_name: 'Dole')
        invoice1 = create(:invoice, customer: customer)
        item1 = create(:item, merchant: merchant1)
        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

        expect(invoice1.customer_name).to eq("Bob Dole")
      end
    end

    describe '#merchant_items' do
      it 'organizes an invoices items by a given merchant' do
        merchant_1 = create(:merchant, name: 'Bob')
        invoice_1 = create(:invoice)
        item_1 = create(:item_with_invoices, invoice_count: 1, name: 'Toy', merchant: merchant_1, invoices: [invoice_1])
        item_2 = create(:item_with_invoices, invoice_count: 1, name: 'Car', merchant: merchant_1, invoices: [invoice_1])

        expect(invoice_1.merchant_items(merchant_1)).to eq([item_1, item_2])
      end
    end

    describe '#merhcant_invoice_items' do
      it 'organizes invoice items alphabetically by a given merchant' do
        merchant_1 = create(:merchant, name: 'Bob')
        invoice_1 = create(:invoice)
        item_1 = create(:item_with_invoices, name: 'Toy', merchant: merchant_1, invoices: [invoice_1])
        item_2 = create(:item_with_invoices, name: 'Apple', merchant: merchant_1, invoices: [invoice_1])
        item_3 = create(:item_with_invoices, name: 'Zed', merchant: merchant_1, invoices: [invoice_1])
        item_4 = create(:item_with_invoices, name: 'Candy', invoices: [invoice_1])
        ## dig into possible refactor with a different factory: need => see item_name, set merchant, set invoice, invoice_item variable

        expect(invoice_1.merchant_invoice_items(merchant_1)).to eq([item_2.invoice_items.first, item_1.invoice_items.first, item_3.invoice_items.first] )
      end
    end

    describe '#potential_revenue' do
      it 'reports potential revenue from all items on a given invoice if there is at least 1 successful transaction' do
        invoice1 = create(:invoice)
        item1 = create(:item_with_invoices, name: 'Toy', invoices: [invoice1], invoice_item_quantity: 3, invoice_item_unit_price: 15000)
        item2 = create(:item_with_invoices, name: 'Car', invoices: [invoice1], invoice_item_quantity: 5, invoice_item_unit_price: 20000)
        transaction_1 = create(:transaction, invoice: invoice1, result: 1)

        expect(invoice1.potential_revenue).to eq(0)

        transaction_2 = create(:transaction, invoice: invoice1, result: 0)
        expect(invoice1.potential_revenue).to eq(145000)
      end
    end

    describe '#potential_revenue_by_merchant' do
      it "reports potential revenue associated with items that belong to a particular merchant that are on a particular invoice" do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        invoice1 = create(:invoice)
        item1 = create(:item_with_invoices, name: 'Toy', merchant: merchant_1, invoices: [invoice1], invoice_item_quantity: 3, invoice_item_unit_price: 15000)
        item2 = create(:item_with_invoices, name: 'Car', merchant: merchant_2, invoices: [invoice1], invoice_item_quantity: 5, invoice_item_unit_price: 20000)
        transaction_2 = create(:transaction, invoice: invoice1, result: 0)

        # revenue associated with this invoice should not be included in potential revenue calcs.
        invoice2 = create(:invoice)
        item3 = create(:item_with_invoices, name: 'Plane', merchant: merchant_1, invoices: [invoice2], invoice_item_quantity: 3, invoice_item_unit_price: 33000)
        item4 = create(:item_with_invoices, name: 'Yoyo', merchant: merchant_2, invoices: [invoice2], invoice_item_quantity: 5, invoice_item_unit_price: 77000)
        transaction_3 = create(:transaction, invoice: invoice2, result: 0)

        expect(invoice1.potential_revenue_by_merchant(merchant_1)).to eq(45000)
        expect(invoice1.potential_revenue_by_merchant(merchant_2)).to eq(100000)
      end
    end

    describe '#admin_potential_revenue' do
      it 'calculates potential revnue of invoice' do
        merchant = create(:merchant)
        invoice = create(:invoice)
        item = create(:item_with_invoices, merchant: merchant, invoices: [invoice], invoice_item_unit_price: 3000, invoice_quantity: 8)
        item2 = create(:item_with_invoices, merchant: merchant, invoices: [invoice], invoice_item_unit_price: 2500, invoice_quantity: 8)

        expect(invoice.admin_potential_revenue).to eq(44000)
      end
    end
  end
end
