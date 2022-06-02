require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe "instance methods" do
    it "#invoice_customer" do
      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      invoice1 = customer1.invoices.create!(status: "cancelled")

      expect(invoice1.invoice_customer).to eq("Leanne Braun")
    end

    it "#total_revenue" do
      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      invoice1 = customer1.invoices.create!(status: "in progress")

      merchant1 = Merchant.create!(name: "REI")
      item1 = merchant1.items.create!(name: "Boots", description: "You wear them!", unit_price: 213)
      item2 = merchant1.items.create!(name: "Jacket", description: "Keeps you warm!", unit_price: 144)

      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 195, status: "packaged")
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 3, unit_price: 130, status: "packaged")
# require "pry"; binding.pry
      expect(invoice1.total_revenue).to eq(1365)
    end
  end
end
