require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to(:merchant) }
  end

  describe "instance methods" do
    it "#matching_invoice_item" do
      @customer = Customer.create!(first_name: "First1", last_name: "Last1")
      @invoice1 = @customer.invoices.create!(status: 1)
      @invoice2 = @customer.invoices.create!(status: 1)
      @merchant = Merchant.create!(name: "Merchant1")
      @item = @merchant.items.create!(name: "Item1", description: "Description1", unit_price: 2)

      @invoice_item1 = InvoiceItem.create!(item: @item, invoice: @invoice1, quantity: 1, unit_price: 1, status: 0)
      @invoice_item2 = InvoiceItem.create!(item: @item, invoice: @invoice2, quantity: 2, unit_price: 2, status: 1)

      expect(@item.matching_invoice_item(@invoice2.id)).to eq(@invoice_item2)
    end
  end
end
