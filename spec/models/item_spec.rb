require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  it 'can create a formatted price for a given num' do
    @merchant_1 = Merchant.create!(name: "Cool Shirts")

    # Item 1 produced 2400 revenue
    @item_1 = @merchant_1.items.create!(name: "Dog", description: "Dog shirt", unit_price: 1400)
    @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_1a = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
    @invoice_item_1b = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1000, status: "packaged")
    @transaction_1 = @invoice_1.transactions.create!(result: "success")

    collection = @merchant_1.top_5_items

    expect(collection.first.revenue_formatted).to eq(24.00)
  end
end
