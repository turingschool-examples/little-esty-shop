require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:customer) }
  end

  describe 'class methods' do
    it '.incomplete' do
      @customer = Customer.create!(first_name: "First1", last_name: "Last1")

      @invoice1 = @customer.invoices.create!(status: 0)
      @invoice2 = @customer.invoices.create!(status: 1)
      @invoice3 = @customer.invoices.create!(status: 2)
      @invoice4 = @customer.invoices.create!(status: 1)

      expect(Invoice.incomplete).to eq([@invoice1, @invoice2, @invoice4])
    end
  end

  describe "instance methods" do
    it "#total_revenue" do
      @customer = Customer.create!(first_name: "First1", last_name: "Last1")
      @invoice = @customer.invoices.create!(status: 1)
      @merchant = Merchant.create!(name: "Merchant1")
      @item1 = @merchant.items.create!(name: "Item1", description: "Description1", unit_price: 2)
      @item2 = @merchant.items.create!(name: "Item2", description: "Description2", unit_price: 3)

      @invoice_item1 = InvoiceItem.create!(item: @item1, invoice: @invoice, quantity: 1, unit_price: 1, status: 0)
      @invoice_item2 = InvoiceItem.create!(item: @item2, invoice: @invoice, quantity: 2, unit_price: 2, status: 1)

      expect(@invoice.total_revenue).to eq(5)
    end
  end
end
