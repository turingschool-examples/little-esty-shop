require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
  end
  describe "relationships" do
     it { should have_many :items }
  end
  describe "instance methods" do
    it "#unshipped_invoice_items returns a merchant's invoice items with unshipped status" do
      merchant = Merchant.create(name: "Need a Merchant")
      item_1 = merchant.items.create!(name: "spoon", description: "stamped stainless steel, not deburred", unit_price: 80, status: 1, merchant_id: merchant.id)
      item_2 = merchant.items.create!(name: "add_foreign_key", description: "stamped stainless steel, not deburred", unit_price: 90, status: 1, merchant_id: merchant.id)
      customer_1 = Customer.create(first_name: "Max", last_name: "Powers")
      invoice_1 = customer_1.invoices.create!(status: 0)
      invoice_2 = customer_1.invoices.create!(status: 0)
      association_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price:75, status:0)
      association_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price:77, status:1)
      association_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 3, unit_price:77, status:2)


      expect(merchant.unshipped_invoice_items.length).to eq(2)
    end
  end
end
