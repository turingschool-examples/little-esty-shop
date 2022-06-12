require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:merchants).through(:item) }
    it { should have_many(:discounts).through(:merchants) }
    it { should have_many(:customers).through(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe '#discount_applied' do
    it "returns the discount applied to an invoice item" do
      merchant1 = Merchant.create!(name: "REI")
      discount1 = merchant1.discounts.create!(percentage: 20, quantity_threshold: 10)
      discount2 = merchant1.discounts.create!(percentage: 30, quantity_threshold: 15)
      customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
      item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
      item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)
      invoice1 = customer1.invoices.create!(status: 2)
      invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 15, unit_price: 100, status: "shipped")
      invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 20, unit_price: 150, status: "pending")

      expect(invoice_item1.applied_discount).to eq(discount2)
    end
  end
end
