require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with(['in progress', 'cancelled', 'completed']) }
  end

  let!(:merch_1) { Merchant.create!(name: 'name_1') }
  let!(:cust_1) { Customer.create!(first_name: 'fn_1', last_name: 'ln_1') }

  let!(:item_1) { Item.create!(name: 'item_1', description: 'desc_1', unit_price: 1, merchant: merch_1) }
  let!(:item_2) { Item.create!(name: 'item_2', description: 'desc_2', unit_price: 2, merchant: merch_1) }
  let!(:item_3) { Item.create!(name: 'item_3', description: 'desc_3', unit_price: 3, merchant: merch_1) }

  let!(:invoice_1) { Invoice.create!(status: 'in progress', customer: cust_1) }
  let!(:invoice_2) { Invoice.create!(status: 'cancelled', customer: cust_1) }
  let!(:invoice_3) { Invoice.create!(status: 'completed', customer: cust_1) }

  let!(:ii_1) { InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1, status: 'pending') }
  let!(:ii_2) { InvoiceItem.create!(item: item_2, invoice: invoice_2, quantity: 2, unit_price: 2, status: 'packaged') }
  let!(:ii_3) { InvoiceItem.create!(item: item_2, invoice: invoice_3, quantity: 3, unit_price: 3, status: 'shipped') }

  describe 'class methods' do
    describe '::merchant_invoices' do
      it 'returns invoices that match the merchant' do
        expect(merch_1.invoices).to eq([invoice_1, invoice_2, invoice_3])
      end
    end
  end
end
