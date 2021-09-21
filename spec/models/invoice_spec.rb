require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  describe 'instance methods' do
    it 'returns the date in words-ish' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled', created_at: "2012-03-25 09:54:09 UTC")

      expect(invoice_1.formatted_date).to eq("Sunday, March 25, 2012")
    end

    it 'returns invoice customer full name' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')

      expect(invoice_1.customer_full_name).to eq("Bob Johnson")
    end

    it 'returns the total revenue from a invoice' do
      merchant_1 = Merchant.create!(name: "Cool Shirts")
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')
      item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id)
      invoice_item1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 5, unit_price: 1200, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 5, unit_price: 1000, status: "packaged")
      expect(invoice_1.total_revenue).to eq(11000)
    end
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Cool Shirts")
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled', created_at: "2012-03-25 09:54:09 UTC")
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress', created_at: "2013-03-25 09:54:09 UTC")
      @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed', created_at: "2011-03-25 09:54:09 UTC")
      @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_1.id)
      @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "pending")
      @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1200, status: "packaged")
      @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 1200, status: "shipped")
      @invoice_item_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 3, unit_price: 1200, status: "shipped")
    end

    it 'returns incomplete invoices in order by created at oldest to newest' do
      one = Invoice.incomplete_invoices_ids_ordered.find do |invoice|
        invoice.id == @invoice_1.id
      end
      expect(one).to_not eq(nil)
      two = Invoice.incomplete_invoices_ids_ordered.find do |invoice|
        invoice.id == @invoice_2.id
      end
      expect(two).to_not eq(nil)
      three = Invoice.incomplete_invoices_ids_ordered.find do |invoice|
        invoice.id == @invoice_3.id
      end
      expect(three).to eq(nil)
      expect(Invoice.incomplete_invoices_ids_ordered.first.id).to eq(@invoice_1.id)
      expect(Invoice.incomplete_invoices_ids_ordered.last.id).to eq(@invoice_2.id)
    end
  end
end
