require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }

  end

  before :each do
    @merchant = Merchant.create!(name: 'BuyMyThings')
    @merchant2 = Merchant.create!(name: 'BuyMyThings')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')

    @invoice1 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice2 =Invoice.create!(status: 0, customer_id: @customer1.id)
    @invoice3 =Invoice.create!(status: 0, customer_id: @customer2.id)

    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: @merchant.id)
    @item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500', merchant_id: @merchant2.id)

    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 400, status: 0)
    @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 2, unit_price: 200, status: 1)
    @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 2)
  end

  describe 'instance methods' do
    describe '.merchant_invoices' do
      it "returns all of the invoices that include a merchant's items" do
        merchant = Merchant.create!(name: 'BuyMyThings')
        merchant2 = Merchant.create!(name: 'BuyMyThings')
        customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
        customer2 = Customer.create!(first_name: 'Tired', last_name: 'Person')

        invoice1 =Invoice.create!(status: 0, customer_id: customer1.id)
        invoice2 =Invoice.create!(status: 0, customer_id: customer1.id)
        invoice3 =Invoice.create!(status: 0, customer_id: customer2.id)

        item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: merchant.id)
        item2 = Item.create!(name: 'more food', description: 'even more delicious', unit_price: '3000', merchant_id: merchant.id)
        item3 = Item.create!(name: 'not food at all', description: 'definitely not food', unit_price: '1500', merchant_id: merchant2.id)

        invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 2, unit_price: 100, status: 1)
        invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 100, status: 1)
        invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 2, unit_price: 100, status: 1)
        expect(merchant.merchant_invoices).to eq([invoice1, invoice2])
        expect(merchant2.merchant_invoices).to eq([invoice3])
      end
    end

    describe '.not_shipped' do
      it "lists invoice items that have been ordered but are not shipped from least to most recent" do
        expect(@merchant.not_shipped).to eq([@invoice_item2, @invoice_item1])
      end
    end

  end
end
