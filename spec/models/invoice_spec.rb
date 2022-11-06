require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  before :each do
    @customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')
    @customer_2 = Customer.create!(first_name: 'Bryan', last_name: 'Keener')
    @customer_3 = Customer.create!(first_name: 'Darby', last_name: 'Smith')
    @customer_4 = Customer.create!(first_name: 'James', last_name: 'White')
    @customer_5 = Customer.create!(first_name: 'William', last_name: 'Lampke')
    @customer_6 = Customer.create!(first_name: 'Abdul', last_name: 'Redd')

    @merchant = Merchant.create!(name: 'Test')

    @item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: @merchant.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_7 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_8 = Invoice.create!(customer_id: @customer_4.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 10, status: 1)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 3, unit_price: 10, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)

    @transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: '2', result: 0, invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: '3', result: 0, invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: '4', result: 0, invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: '5', result: 0, invoice_id: @invoice_8.id)
  end

  describe 'class methods' do
    describe '#incomplete_invoices' do
      it 'returns all invoices that have items that have not been shipped' do
        expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_3, @invoice_4, @invoice_5])
      end
    end
  end
end
