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

  describe 'instant methods' do
    describe '#customer_name' do
      it 'displays a customers first and last name' do
        merchant1 = create(:merchant)
        invoice1 = create(:invoice)
        item1 = create(:item, merchant: merchant1)
        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

        expect(invoice1.customer_name).to eq("Default First Name 1 Default Last Name 1")
      end
    end

    describe '#merchant_items' do
      it 'organizes an invoices items by a given merchant' do
        merchant_1 = create(:merchant, name: 'Bob')
        invoice_1 = create(:invoice)
        item_1 = create(:item_with_invoices, invoice_count: 1, name: 'Toy', merchant: merchant_1, invoice: invoice_1)
        item_2 = create(:item_with_invoices, invoice_count: 1, name: 'Car', merchant: merchant_1, invoice: invoice_1)
        item_3 = create(:item_with_invoices, name: 'Candy', invoice: invoice_1)

        expect(invoice_1.merchant_items(merchant_1)).to eq([item_1, item_2])
      end
    end

    describe '#merhcant_invoice_items' do
      it 'organizes invoice items by a given merchant' do
        merchant_1 = create(:merchant, name: 'Bob')
        invoice_1 = create(:invoice)
        item_1 = create(:item_with_invoices, name: 'Toy', merchant: merchant_1, invoice: invoice_1)
        item_3 = create(:item_with_invoices, name: 'Candy', invoice: invoice_1)


        expect(invoice_1.merchant_invoice_items(merchant_1)).to eq(item_1.invoice_items)
      end
    end

    describe '#potential_revenue' do
      it 'reports potential revenue from all items on a given invoice' do
        merchant1 = create(:merchant, name: "Bob Barker")
        invoice1 = create(:invoice)
        item = create(:item_with_invoices, invoice_count: 1, name: 'Toy', merchant: merchant1, invoice: invoice1, invoice_item_unit_price: 15000)
        item2 = create(:item_with_invoices, name: 'Car', merchant: merchant1, invoice: invoice1, invoice_item_unit_price: 20000)

        expect(invoice1.potential_revenue(merchant1)).to eq(55000)
      end
    end
  end
end
