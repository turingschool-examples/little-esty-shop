require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    # it { should have_many(:customers).through(:invoices) }
    # it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'instance method' do
    it "returns the array of invoice ids for a merchant" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes")
      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
			invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice2.id)

      expect(merchant1.merchant_invoice_by_item_id).to eq([invoice1.id, invoice2.id])
    end
  end
end
