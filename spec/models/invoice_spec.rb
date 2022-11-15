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

  describe 'instance methods' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Marvel', status: 'enabled')
      @merchant_2 = Merchant.create!(name: 'D.C.', status: 'disabled')
      
      @discount_1 = BulkDiscount.create!(percentage: 15, quantity_threshold: 5, merchant_id: @merchant_1.id)
      @discount_2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 10, merchant_id: @merchant_1.id)
      @discount_3 = BulkDiscount.create!(percentage: 10, quantity_threshold: 2, merchant_id: @merchant_2.id)
      
      @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
      @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent') 
      
      @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: Time.parse('21.01.28'))
      @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: Time.parse('22.08.22'))
      
      @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant_1.id)
      @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant_2.id)
      
      InvoiceItem.create!(quantity: 5, unit_price: 500, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
      InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
      
      InvoiceItem.create!(quantity: 50, unit_price: 5000, status: 'shipped', item_id: @item2.id, invoice_id: @invoice1.id)
      InvoiceItem.create!(quantity: 15, unit_price: 1500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice2.id)
      
      @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
      @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
      @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    end

    describe '#all_revenue' do
      it 'returns revenue generated from all transactions on invoice' do
        expect(@invoice1.all_revenue).to eq(252500)
      end
    end
    
    describe '#total_revenue' do
      it 'totals revenue from all invoice items' do
        expect(@invoice1.total_revenue(@merchant_1)).to eq(2500)
      end
    end

    describe '#merchant_invoice_items_discount' do
      it 'returns the total value of discounts for an invoice items for a merchant' do
        expect(@invoice1.merchant_invoice_items_discount(@merchant_1)).to eq(375.0)
      end
    end

    describe '#revenue_with_discount' do
      it 'returns the total revenue for a merchant with discounts applied' do
        expect(@invoice1.revenue_with_discount(@merchant_1)).to eq(2125.0)
      end
    end

    describe '#invoice_items_discount' do
      it 'returns the sum of discounts for all items on invoice' do
        expect(@invoice1.invoice_items_discount).to eq(25375)
      end
    end
    
    describe '#all_merchants_discounts_revenue' do
      it 'returns the discounted reveune with all merchants discounts' do
        expect(@invoice1.all_merchants_discounts_revenue).to eq(227125)
      end
    end
  end
end
