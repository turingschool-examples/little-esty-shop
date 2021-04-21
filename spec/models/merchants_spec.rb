require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Ice Cream Parlour', status: "disabled")
      @merchant2 = Merchant.create!(name: 'Inked', status: "disabled")
      @merchant3 = Merchant.create!(name: 'Plants', status: "enabled")
      @merchant4 = Merchant.create!(name: 'Water Corp', status: "enabled")
      @merchant5 = Merchant.create!(name: 'Chocolates', status: "disabled")


      @item_1 = create(:item, merchant: @merchant1)
      @item_2 = create(:item, merchant: @merchant2)
      @item_3 = create(:item, merchant: @merchant3)
      @item_4 = create(:item, merchant: @merchant4)
      @item_5 = create(:item, merchant: @merchant5)

      @customer = create(:customer)
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)

      @invoice_1 = Invoice.create!(status: 0, customer_id: @customer.id)
      @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
      @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
      @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_3.id)
      @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_4.id)
      @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_5.id)

      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 0)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 2, status: 2)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 40, status: 2)
      InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 5, status: 2)
      InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 2, status: 2)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 3, unit_price: 5, status: 2)

      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")

    end

    describe '::disabled_merchants' do
      it 'finds rows where merchants are disabled' do
        expect(Merchant.disabled_merchants).to eq([@merchant1, @merchant2, @merchant5])
        expect(Merchant.disabled_merchants).to_not eq([@merchant3, @merchant4])
      end
    end

    describe '::enabled_merchants' do
      it 'finds rows where merchants are enabled' do
        expect(Merchant.enabled_merchants).to eq([@merchant3, @merchant4])
        expect(Merchant.enabled_merchants).to_not eq([@merchant1, @merchant2, @merchant5])
      end
    end

    describe '::top_merchants_revenue' do
      it 'shows merchants who created the most revenue' do
        expect(Merchant.top_merchants_revenue).to eq([@merchant3, @merchant2, @merchant4, @merchant1, @merchant5])
      end
    end
  end
end
