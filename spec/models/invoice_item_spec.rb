require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  let!(:customer) { Customer.create!(first_name: "Joe", last_name: "Customer") }
  let!(:invoice) { customer.invoices.create!(status: 0) }
  let!(:merchant) { Merchant.create!(name: "Store") }
  let!(:item) { merchant.items.create!(name: "Item", description: "Is a thing", unit_price: 25) }
  let!(:invoice_item) { InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 6, unit_price: 25, status: 1) }
  let!(:bulk_discount_a) { merchant.bulk_discounts.create!(percentage: 0.2, quantity: 5) }
  let!(:bulk_discount_b) { merchant.bulk_discounts.create!(percentage: 0.9, quantity: 7) }

  describe "instance methods" do
    it "#has_discount? determines if discount applies" do
      expect(invoice_item.has_discount?).to eq(true)
    end

    it "#bulk_discount returns correct discount for invoice item" do
      expect(invoice_item.bulk_discount).to eq(bulk_discount_a)
      expect(invoice_item.bulk_discount).to_not eq(bulk_discount_b)
    end
  end
end
