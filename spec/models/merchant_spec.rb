require 'rails_helper'

RSpec.describe Merchant do

  describe 'associations' do
    it { should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'instance methods' do

    describe '#items_ready_to_ship' do
      before :each do
        @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

        @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
        @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
        @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
      
        @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
        @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    
        @invoice_1 = @cust_1.invoices.create!(status: 1)
        @invoice_2 = @cust_1.invoices.create!(status: 1)
        @invoice_3 = @cust_1.invoices.create!(status: 1)
        @invoice_4 = @cust_2.invoices.create!(status: 1)
        @invoice_5 = @cust_2.invoices.create!(status: 1)
    
        @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
        @ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
        @ii_3 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_2.unit_price, status: 2)
        @ii_4 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_3.unit_price, status: 2)
        @ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
        @ii_6 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_2.unit_price, status: 1)
      end

      it 'returns the items that have not yet been shipped for a particular merchant' do
        expect(@merch_1.items_ready_to_ship).to eq([@item_1, @item_2])
      end
    end

  end
end