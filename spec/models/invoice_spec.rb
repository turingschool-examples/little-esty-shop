require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many(:transactions)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with(['in progress', 'cancelled', 'completed']) }
  end

  # let!(:merch_1) { Merchant.create!(name: 'name_1') }
  # let!(:cust_1) { Customer.create!(first_name: 'fn_1', last_name: 'ln_1') }

  # let!(:item_1) { Item.create!(name: 'item_1', description: 'desc_1', unit_price: 1, merchant: merch_1) }
  # let!(:item_2) { Item.create!(name: 'item_2', description: 'desc_2', unit_price: 2, merchant: merch_1) }
  # let!(:item_3) { Item.create!(name: 'item_3', description: 'desc_3', unit_price: 3, merchant: merch_1) }

  # let!(:invoice_1) { Invoice.create!(status: 'in progress', customer: cust_1) }
  # let!(:invoice_2) { Invoice.create!(status: 'cancelled', customer: cust_1) }
  # let!(:invoice_3) { Invoice.create!(status: 'completed', customer: cust_1) }

  # let!(:ii_1) { InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1, status: 'pending') }
  # let!(:ii_2) { InvoiceItem.create!(item: item_2, invoice: invoice_2, quantity: 2, unit_price: 2, status: 'packaged') }
  # let!(:ii_3) { InvoiceItem.create!(item: item_2, invoice: invoice_3, quantity: 3, unit_price: 3, status: 'shipped') }

  describe 'class methods' do

  end

  describe 'instance methods' do
    describe '#created_at_formatted' do
      it 'should return created_at date formatted' do
        invoice_1 = build(:invoice, created_at: DateTime.new(2022, 1, 5, 0 , 0, 0))
  
        expect(invoice_1.created_at_formatted).to eq('Wednesday, January 5, 2022')
      end
    end

    describe '#customer_full_name' do
      it 'should return the invoice customers full name' do
        customer_1 = build(:customer, first_name: 'Joe', last_name: 'Dirt')
        invoice_1 = build(:invoice, customer: customer_1)

        expect(invoice_1.customer_full_name).to eq('Joe Dirt')
      end
    end

    describe '#total_revenue' do
      it 'should return the total revenue for the invoice' do
        invoice_1 = create(:invoice)
        items = create_list(:item, 3)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 200)
        invoice_item_3 = create(:invoice_item, item: items[2], invoice: invoice_1, unit_price: 300)

        expect(invoice_1.total_revenue).to eq('$6.00')
      end
      
      it 'should not return revenue from other items not on the invoice' do
        invoice_1 = create(:invoice)
        item_1 = create(:item)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 100)

        invoice_item_2 = create(:invoice_item, unit_price: 200)

        expect(invoice_1.total_revenue).to eq('$1.00')
      end
    end
  end
end
