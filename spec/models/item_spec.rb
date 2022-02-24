require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end
  it "Shows the best revenue day" do
    merchant_1 = Merchant.create!(name: "Staples")

    customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

    item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)

    invoice_1 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 23))##

    invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 13, status: "shipped")

    invoice_9 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2021, 12, 18))

    invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_1.id, quantity: 1, unit_price: 1, status: "shipped")

    expect(item_1.best_day).to eq(DateTime.new(2022, 2, 23))
  end
end
