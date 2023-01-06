require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'instance methods' do
    describe '#pending_invoices' do
      it 'returns invoices with status pending for a merchant' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)

        expect(merchant1.pending_invoices).to eq([invoice1])

        invoice2 = Invoice.create!(status: 1, customer_id: customer.id)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice2.id)

        expect(merchant1.pending_invoices).to eq([invoice1, invoice2])
      end

      it 'does not return pending invoices for other merchants' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)
        invoice2 = Invoice.create!(status: 1, customer_id: customer.id)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice2.id)
        merchant2 = Merchant.create!(name: 'Pizza Man')
        item2 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant2.id)
        invoice3 = Invoice.create!(status: 1, customer_id: customer.id)
        ii3 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item2.id, invoice_id: invoice3.id)

        expect(merchant1.pending_invoices).to eq([invoice1, invoice2])
        expect(merchant2.pending_invoices).to eq([invoice3])
      end

      it 'does not return invoices with statuses other than pending' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 0, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)

        expect(merchant1.pending_invoices).to eq([])
      end

      it 'orders invoices from oldest to newest' do
        merchant1 = Merchant.create!(name: 'Rays Hand Made Jewlery')
        item1 = Item.create!(name: 'Chips', description: 'Ring', unit_price: 20, merchant_id: merchant1.id)
        customer = Customer.create!(first_name: 'Kyle', last_name: 'Ledin')
        invoice1 = Invoice.create!(status: 1, customer_id: customer.id)
        ii1 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)
        invoice2 = Invoice.create!(status: 1, customer_id: customer.id, created_at: Time.now-5.days)
        ii2 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice2.id)
        invoice3 = Invoice.create!(status: 1, customer_id: customer.id, created_at: Time.now-15.days)
        ii3 = InvoiceItem.create!(quantity: 5, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice3.id)

        expect(merchant1.pending_invoices).to eq([invoicer3, invoice2, invoice1])
      end
    end
  end
end
