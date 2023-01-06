require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'instance_methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Billy the Guy")
      @merchant_2 = Merchant.create!(name: "Different Guy")

      @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
      @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
      @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
      @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
      @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
      @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")
      @customer_7 = Customer.create!(first_name: "Donald", last_name: "Duck")

      @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)
      @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id)
      @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id)
      @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id)
      @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_7.id)
      @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_1.id)
      @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id)
      @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_2.id)
      @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_3.id)
      @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_4.id)
      @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_5.id)

      @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "Tamagotchi", description: "Super annoying", unit_price: 800, merchant_id: @merchant_1.id, status: 1)

      @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
      @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
      @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
      @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
      @ii_5 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
      @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
      @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_7.id)
      @ii_8 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_8.id)
      @ii_9 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_9.id)
      @ii_10 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_10.id)
      @ii_11 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_11.id)
      @ii_12 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_12.id)
      @ii_13 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_13.id)
      
      @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
      @transaction_7 = Transaction.create!(credit_card_number: "4654407418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_7.id)
      @transaction_8 = Transaction.create!(credit_card_number: "4653405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_8.id)
      @transaction_9 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_9.id)
      @transaction_10 = Transaction.create!(credit_card_number: "4654435418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_10.id)
      @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_11.id)
      @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
      @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
    end

    describe '#change_status' do
      it 'changes an items status' do
        expect(@item_1.status).to eq('disabled')
        
        @item_1.change_status
        
        expect(@item_1.status).to eq('enabled')

        @item_1.change_status
        
        expect(@item_1.status).to eq('disabled')
      end
    end

    describe '#enabled_items' do
      it 'returns an array of enabled items' do
        items = Item.all
        expect(items.enabled_items).to eq([@item_3])
      end
    end

    describe '#disabled_items' do
      it 'returns an array of disabled items' do
        items = Item.all
        expect(items.disabled_items).to eq([@item_1, @item_2])
      end
    end
  end
end