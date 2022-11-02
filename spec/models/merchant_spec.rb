require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items) }
  end
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Dave")
    @merchant_2 = Merchant.create!(name: "Kevin")

    @merchant_1_item_1 = @merchant_1.items.create!(name: "Pencil", description: "Writing implement", unit_price: 1)
    @merchant_2_item_1 = @merchant_2.items.create!(name: "Mechanical Pencil", description: "Writing implement", unit_price: 2)

    @customer_1 = Customer.create!(first_name: "Bob", last_name: "Jones")
    @customer_2 = Customer.create!(first_name: "Sarag", last_name: "Smith")

    @customer_1_invoice_1 = @customer_1.invoices.create!(status: 2)
    @customer_1_invoice_2 = @customer_1.invoices.create!(status: 2)

    @customer_2_invoice_1 = @customer_2.invoices.create!(status: 2)
    @customer_2_invoice_2 = @customer_2.invoices.create!(status: 2)

    @customer_1_invoice_1_item_1_pachaged = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
    @customer_1_invoice_1_item_1_shipped = InvoiceItem.create!(invoice: @customer_1_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 2)
    @customer_1_invoice_2_item_1_merchant_2 = InvoiceItem.create!(invoice: @customer_1_invoice_2, item: @merchant_2_item_1, quantity: 1, unit_price: 4, status: 0)
    @customer_2_invoice_1_item_1_packaged = InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 4, status: 0)
  end
  describe "instance methods" do
    describe '.invoice_items_to_ship' do
      describe 'returns an array of invoice_items' do
        it 'where invoice_item is "packaged" (0)' do
          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_pachaged, @customer_2_invoice_1_item_1_packaged])
        end
        it 'ordered by invoice created_at, NOT invoice_item created_at' do
          customer_2_invoice_1 = InvoiceItem.create!(invoice: @customer_2_invoice_1, item: @merchant_1_item_1, quantity: 1, unit_price: 3, status: 0)

          expect(@merchant_1.invoice_items_to_ship).to eq([@customer_1_invoice_1_item_1_pachaged, customer_2_invoice_1, @customer_2_invoice_1_item_1_packaged])
        end
      end
    end
  end
end