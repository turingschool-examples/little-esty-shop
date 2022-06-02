require 'rails_helper'

RSpec.describe Invoice do
  describe 'associations' do
    it { should belong_to :customer}
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(['cancelled', 'in progress', 'completed'])}
  end

  describe 'class methods' do
    before :each do
      @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

      @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    
      @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
      @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")

      @invoice_1 = @cust_1.invoices.create!(status: 1)
      @invoice_2 = @cust_1.invoices.create!(status: 1)
      @invoice_3 = @cust_1.invoices.create!(status: 1)
      @invoice_4 = @cust_2.invoices.create!(status: 1)
      @invoice_5 = @cust_2.invoices.create!(status: 1)
      @invoice_6 = @cust_2.invoices.create!(status: 1)

      @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
      @ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @ii_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
      @ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @ii_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
    end
    describe '#incomplete_invoices_ordered' do
      it 'returns incomplete invoices orderd from oldest to newest' do
        expect(Invoice.incomplete_invoices_ordered).to eq([@invoice_1, @invoice_2, @invoice_4, @invoice_5])
      end
    end
  end
end