require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  it "exists" do
    invoice = create(:invoice)
    expect(invoice).to be_a(Invoice)
    expect(invoice).to be_valid
  end

  it 'total_revenue' do
    merchant1 = Merchant.create!(name: 'Chuckin Pucks')
    customer = Customer.create!(first_name: 'Samantha', last_name: 'Ore')
    item_1 = Item.create!(name: "Shampoo", description: "Cleans the lettuce", unit_price: 5, merchant_id: merchant1.id)
    item_2 = Item.create!(name: "Tape", description: "Grips and rips pucks", unit_price: 2, merchant_id: merchant1.id)
    invoice_1 = Invoice.create!(customer_id: customer.id, status: 2)
    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 1, created_at: "2012-03-29 14:54:09")

    expect(invoice_1.total_revenue).to eq(100)
  end
end
